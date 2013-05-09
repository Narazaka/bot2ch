require "spec_helper"

describe Bot2ch::Menu do
  it do
    VCR.use_cassette("boards") do
      @boards = Bot2ch::Menu.boards
    end
    @boards.should be_a_kind_of(Array)
  end

  it do
    VCR.use_cassette("get_board") do
      @get_board = Bot2ch::Menu.get_board("ff")
    end
    @get_board.should be_a_kind_of(Bot2ch::Board)
  end
end
