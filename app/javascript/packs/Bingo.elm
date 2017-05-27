module Bingo exposing (..)

import Html exposing (Html, text, h2, h1, a, footer, header, div, ul, li, span, button, input)
import Html.Attributes exposing (id, class, href, classList, type_, placeholder, autofocus, value)
import Html.Events exposing (onClick, onInput)
import Random
import Http
import Json.Decode as Decode exposing (Decoder, field, succeed)


-- MODEL


type alias Entry =
    { id : Int, phrase : String, points : Int, marked : Bool }


type alias Model =
    { name : String
    , gameNumber : Int
    , entries : List Entry
    , nameInput : String
    }


initialModel : Model
initialModel =
    { name = "Anonymous"
    , gameNumber = 1
    , entries = []
    , nameInput = ""
    }



-- UPDATE


type Msg
    = NewGame
    | Mark Int
    | NewRandom Int
    | NewEntries (Result Http.Error (List Entry))
    | SetNameInput String
    | SaveName
    | CancelName


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SaveName ->
            ( { model | name = model.nameInput, nameInput = "" }, Cmd.none )

        CancelName ->
            ( { model | nameInput = "" }, Cmd.none )

        SetNameInput value ->
            ( { model | nameInput = value }, Cmd.none )

        NewEntries (Ok randomEntries) ->
            ( { model | entries = randomEntries |> List.sortBy .points |> List.reverse }, Cmd.none )

        NewEntries (Err error) ->
            let
                _ =
                    Debug.log "Oops!" error
            in
                ( model, Cmd.none )

        NewRandom randomNumber ->
            ( { model | gameNumber = randomNumber }, Cmd.none )

        NewGame ->
            ( { model | gameNumber = model.gameNumber + 1 }, getEntries )

        Mark id ->
            let
                markEntry entry =
                    if entry.id == id then
                        { entry | marked = (not entry.marked) }
                    else
                        entry
            in
                ( { model | entries = List.map markEntry model.entries }, Cmd.none )



-- DECODERS


entryDecoder : Decoder Entry
entryDecoder =
    Decode.map4 Entry (field "id" Decode.int) (field "phrase" Decode.string) (field "points" Decode.int) (succeed False)



-- COMMANDS


generateRandomNumber : Cmd Msg
generateRandomNumber =
    Random.generate NewRandom (Random.int 1 100)


getEntries : Cmd Msg
getEntries =
    Http.send NewEntries (Http.get "/random-entries" (Decode.list entryDecoder))



-- VIEW


playerInfo : String -> Int -> String
playerInfo name gameNumber =
    name ++ " - Game #" ++ (toString gameNumber)


viewPlayer : String -> Int -> Html msg
viewPlayer name gameNumber =
    let
        playerInfoText =
            playerInfo name gameNumber
                |> String.toUpper
                |> text
    in
        h2 [ id "info", class "classy" ]
            [ playerInfoText ]


viewHeader : String -> Html msg
viewHeader title =
    header []
        [ h1 [] [ text title ]
        ]


viewFooter : Html msg
viewFooter =
    footer []
        [ a [ href "http://elm-lang.org" ]
            [ text "Powered by Elm" ]
        ]


viewEntryList : List Entry -> Html Msg
viewEntryList entries =
    entries
        |> List.map viewEntryItem
        |> ul []


addEntryPoints : List Entry -> Int
addEntryPoints entries =
    entries
        |> List.filter .marked
        |> List.map .points
        |> List.sum


viewEntryItem : Entry -> Html Msg
viewEntryItem entry =
    li [ classList [ ( "marked", entry.marked ) ], onClick (Mark entry.id) ]
        [ span [ class "phrase" ] [ text entry.phrase ]
        , span [ class "points" ] [ text (toString entry.points) ]
        ]


viewTotal : Int -> Html msg
viewTotal number =
    div [ class "score" ]
        [ span [ class "label" ] [ text "Score" ]
        , span [ class "value" ] [ text (toString number) ]
        ]


viewNameInput : Model -> Html Msg
viewNameInput model =
    div [ class "name-input" ]
        [ input
            [ type_ "text"
            , placeholder "Who's playing?"
            , autofocus True
            , value model.nameInput
            , onInput SetNameInput
            ]
            []
        , button [ onClick SaveName ] [ text "Save" ]
        , button [ onClick CancelName ] [ text "Cancel" ]
        ]


view : Model -> Html Msg
view model =
    div [ class "content" ]
        [ viewHeader "BUZZWORD BINGO"
        , viewPlayer model.name model.gameNumber
        , viewNameInput model
        , viewEntryList model.entries
        , viewTotal (addEntryPoints model.entries)
        , div [ class "button-group" ]
            [ button [ onClick NewGame ] [ text "New Game" ] ]
        , viewFooter
        ]


main : Program Never Model Msg
main =
    Html.program
        { init = ( initialModel, getEntries )
        , update = update
        , view = view
        , subscriptions = (\model -> Sub.none)
        }
