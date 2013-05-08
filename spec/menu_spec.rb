require "spec_helper"

describe Bot2ch::Menu do
  before{ @menu = Bot2ch::Menu.new }
  let(:board){ "ff" }

  it do
    VCR.use_cassette("boards") do
      @boards = @menu.boards
    end
    @boards.should be_a_kind_of(Array)
  end

  it do
    VCR.use_cassette("get_board") do
      @get_board = @menu.get_board(board)
    end
    @get_board.should be_a_kind_of(Bot2ch::Board)
  end
end
