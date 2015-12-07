require 'optparse'

module TicTacToe
  module TicTacToeOptionsParser

    def self.setup_parser(argv={})
      @options = {}

      @opt_parser = OptionParser.new do |opt|
        opt.banner =  'Usage: tic_tac_toe COMMAND [OPTIONS]'
        opt.separator ''
        opt.separator 'Commands'
        opt.separator '     pvp: player   vs  player'
        opt.separator '     pvc: player   vs  computer'
        opt.separator '     cvp: computer vs  player'
        opt.separator '     pvp: computer vs  computer'
        opt.separator ''
        opt.separator 'Options'

        opt.on('-h', '--help', 'help') do
          puts @opt_parser
        end

        opt.on('-n', '--names PLAYER1,PLAYER2', Array, 'Player names') do |names|
          options[:player1name] = names[0]
          options[:player2name] = names[1]
        end

        opt.separator ''
        opt.separator ''
      end
    end
  end
end
