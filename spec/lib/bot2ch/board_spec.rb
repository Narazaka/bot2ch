require "spec_helper"

describe Bot2ch::Board do
  before do
    @board = Bot2ch::Board.new("http://ikura.2ch.net/football/")
  end

  it do
    VCR.use_cassette("threads") do
      @threads = @board.threads
    end
    expect(@threads).to be_a_kind_of Array
  end
end
