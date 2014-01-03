require "spec_helper"

describe Bot2ch::Board do
  context "when Remote" do
    let(:board) do
      Bot2ch::Board.new("http://ikura.2ch.net/football/")
    end

    it do
      expect(board.directory).to eq "football"
    end

    describe "#threads" do
      let(:threads) do
        VCR.use_cassette("threads") do
          @threads = board.threads
        end
      end

      it_behaves_like "a board" do
        let(:expectation){ Bot2ch::Thread }
      end
    end
  end

  context "when Local" do
    let(:board) do
      Bot2ch::Board.new("./spec/dummy/subject.txt")
    end

    describe "#threads" do
      let(:threads) do
        @threads = board.threads
      end

      it_behaves_like "a board" do
        let(:expectation){ Bot2ch::Thread }
      end
    end
  end
end
