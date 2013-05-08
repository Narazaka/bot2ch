require "spec_helper"

describe Bot2ch::Board do
  let(:url){ "http://ikura.2ch.net/football/" }
  before{ @board = Bot2ch::Board.new(url) }

  it do
    VCR.use_cassette("get_threads") do
      @get_threads = @board.get_threads
    end
    @get_threads.should be_a_kind_of(Array)
  end
end
