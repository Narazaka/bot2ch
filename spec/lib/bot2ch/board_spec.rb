require "spec_helper"

describe Bot2ch::Board do
  before do
    @board = Bot2ch::Board.new("http://ikura.2ch.net/football/")
  end

  describe "#threads" do
    let(:threads) do
      VCR.use_cassette("threads") do
        @threads = @board.threads
      end
    end

    it_behaves_like "a board" do
      let(:expectation){ Bot2ch::Thread }
    end
  end
end
