require 'spec_helper'
require_relative '../../cla/tic_tac_toe/ui'

include TicTacToe
describe UI do
  before(:each) do 
    @input  = StringIO.new('hello')
    @output = StringIO.new
  end

  it 'outputs msg' do 
    expect(@output).to receive(:puts).with('hello')
    UI.output('hello', @output)
  end

  it 'receives msg' do
    resp = UI.receive(@input)
    expect(resp).to eq('hello')
  end
end