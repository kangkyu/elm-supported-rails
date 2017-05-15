# README

a practice app using webpacker elm support

## Memorandom

generate a new rails app

```sh
rails new rails_app_with_elm_support --webpack
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
rails new rails_app_with_elm_support --webpack=elm
```

```sh
rails server
bin/webpack-dev-server # don't forget
```

`<%= javascript_pack_tag "hello_elm" %>` on some page
as commented at `app/javascript/packs/hello_elm.js`


## buzzword bingo

Elm tutorial from Pragmatic Studio

https://pragmaticstudio.com/courses/elm

but with Rails code (with webpacker elm) such as

```ruby
@entries = Entry.order("RANDOM()").limit(5)
```
