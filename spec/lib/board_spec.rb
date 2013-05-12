require "spec_helper"

describe Bot2ch::Board do
  let(:url){ "http://ikura.2ch.net/football/" }
  before{ @board = Bot2ch::Board.new(url) }

  it do
    VCR.use_cassette("threads") do
      @threads = @board.threads
    end
    @threads.should be_a_kind_of(Array)
  end
end
