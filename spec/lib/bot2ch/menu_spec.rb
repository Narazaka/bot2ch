require "spec_helper"

describe Bot2ch::Menu do
  describe ".menu" do
    let(:menu) do
      VCR.use_cassette("boards") do
        Bot2ch::Menu.menu
      end
    end

    it do
      expect(menu).to be_a_kind_of Array
    end

    it do
      expect(menu).to be_all{ |board| board.kind_of?(Bot2ch::Board) }
    end
  end

  describe ".get_board" do
    let(:get_board) do
      VCR.use_cassette("get_board") do
        Bot2ch::Menu.get_board("ff")
      end
    end

    it do
      expect(get_board).to be_a_kind_of Bot2ch::Board
    end
  end
end
