require "spec_helper"

describe Bot2ch::Shitaraba::Board do
  let(:board) do
    Bot2ch::Shitaraba::Board.new("http://jbbs.shitaraba.net/computer/36814/")
  end

  describe "#threads" do
    let(:threads) do
      VCR.use_cassette "shitaraba/threads" do
        board.threads
      end
    end

    it_behaves_like "a board" do
      let(:expectation){ Bot2ch::Shitaraba::Thread }
    end
  end
end
