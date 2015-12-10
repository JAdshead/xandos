# XAndOs

x_and_os provides the basic structure and game logic to easily create a Tic Tac Toe game.
It also comes with a mini command line app to play Tic Tac Toe / x and os. 

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'x_and_os'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install x_and_os

## Usage

```ruby
require 'x_and_os'
```

### Game
Used to manage the basic state of game.

Initialze a new game with:

```ruby
XAndOS::Game.new
```
or

```ruby
include XAndOs

Game.new

```
By default `Game.new` will create a new game object that uses the XAndOs::Board with a 3x3 grid.

It is possible to pass set *rows* and *columns*
when instantiating a new Game `Game.new`

```ruby
XAndOs::Game.new(rows: 4, columns: 3)

```

If you wish to use a different game board (not recommended):

```ruby
custom_game_board = Board.new

Game.new(board: custom_game_board)
```


### Board


### Game Mastery
  TODO

### Command Line App
You can use x_and_os to play Tic Tac Toe / X and Os in the command line.
After installing the gem run :

  $ x_and_os

And then follow the menu options.

- Quick game sets up a You vs Computer on 3x3 game board.
- settings allows the user to 
  - pick two players (either player(human) or computer)
  - choose a grid size to play on. e.g 3x3 or 5x5 
- The computer player uses the GameMaster class to be make the best possible moves (unbeatable on 3x3 board)

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/x_and_os/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
