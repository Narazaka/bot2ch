require "spec_helper"

describe Bot2ch::Menu do
  it ".menu" do
    VCR.use_cassette("boards") do
      @menu = Bot2ch::Menu.menu
    end
    expect(@menu).to be_a_kind_of Array
  end

  it ".get_board" do
    VCR.use_cassette("get_board") do
      @get_board = Bot2ch::Menu.get_board("ff")
    end
    expect(@get_board).to be_a_kind_of Bot2ch::Board
  end
end
