require "spec_helper"

describe Bot2ch::Menu do
  it "board" do
    VCR.use_cassette("boards") do
      @boards = Bot2ch::Menu.boards
    end
    expect(@boards).to be_a_kind_of(Array)
  end

  it "get_board" do
    VCR.use_cassette("get_board") do
      @get_board = Bot2ch::Menu.get_board("ff")
    end
    expect(@get_board).to be_a_kind_of(Bot2ch::Board)
  end
end
