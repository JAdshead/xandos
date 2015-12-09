module TicTacToe
  module UI
    def self.output(output_msg=nil, stdout= $stdout )
      stdout.puts output_msg
      # raise 'output called'
    end

    def self.receive(stdin= $stdin )
      stdin.gets.chomp
      # raise 'input called'
    end
  end
end