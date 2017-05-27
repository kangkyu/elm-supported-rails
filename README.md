# README

a practice app using webpacker elm support

## Memorandom

generate a new rails app

```sh
rails new elm-supported-rails --webpack
```

get newest webpacker

```ruby
# Gemfile
gem 'webpacker', git: 'https://github.com/rails/webpacker.git', branch: 'master'
```

```sh
bundle
rails webpacker:install
rails webpacker:install:elm
```

alternatively you can (after the new version webpacker with elm support released)

```sh
rails new elm-supported-rails --webpack=elm
```

```sh
rails server
bin/webpack-dev-server # don't forget
```

`<%= javascript_pack_tag "hello_elm" %>` on some page
as commented at `app/javascript/packs/hello_elm.js` file


## buzzword bingo

Elm tutorial from Pragmatic Studio

https://pragmaticstudio.com/courses/elm

but with Rails code (with webpacker elm) such as

```ruby
@entries = Entry.order("RANDOM()").limit(5)
```

## deploy to Heroku

add path `"pathToMake=node_modules/.bin/elm-make"`
to `config/webpack/loaders/elm.js` file
=> Is this necessary for heroku?

added that to avoid this error.
```
Could not find Elm compiler "elm-make". Is it installed?
```

live on [buzzword-bingo-from-pragstudio.herokuapp.com](https://buzzword-bingo-from-pragstudio.herokuapp.com/)

## Todo

+ Add input field (Lesson 20)
