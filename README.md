# SinatraWebsocketTemplate

`SinatraWebsocketTemplate` is for generating a skeleton of WebSocket application with Ruby(Sinatra)

A concept of the skeleton code is inspired by the following article:

> [Using WebSockets on Heroku with Ruby | Heroku Dev Center](https://devcenter.heroku.com/articles/ruby-websockets "Using WebSockets on Heroku with Ruby | Heroku Dev Center")

## Installation

    $ gem install sinatra_websocket_template

## Usage

4 steps to run a skeleton demo application;

    $ sinatra_websocket_template new YOUR_PROJECT_NAME

    $ cd YOUR_PROJECT_NAME

    $ bundle install

    $ bundle exec foreman start

Open http://localhost:5000 to review it, then modify it as you like.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
