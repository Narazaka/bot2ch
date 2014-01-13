# -*- coding: utf-8 -*-
require "spec_helper"

describe Bot2ch::Menu do
  VCR.use_cassette("boards") do
    Bot2ch::Menu.boards         # cache
  end

  describe ".menu" do
    it do
      expect(Bot2ch::Menu.menu).to be_a_kind_of Array
    end

    it do
      expect(Bot2ch::Menu.menu).to be_all{ |board| board.kind_of?(Bot2ch::Board) }
    end
  end

  describe ".get_board" do
    context "with strings" do
      it do
        expect(Bot2ch::Menu.get_board("ff")).to be_a_kind_of Bot2ch::Board
      end
    end

    context "with regexp" do
      it do
        expect(Bot2ch::Menu.get_board(/ff/)).to be_a_kind_of Bot2ch::Board
      end
    end
  end

  describe ".get_boards" do
    context "with strings" do
      it do
        expect(Bot2ch::Menu.get_boards("ff")).to be_a_kind_of Array
      end

      it do
        expect(Bot2ch::Menu.get_boards("ff")).to be_all{ |board| board.is_a?(Bot2ch::Board) }
      end
    end

    context "with regexp" do
      it do
        expect(Bot2ch::Menu.get_boards(/ff/)).to be_a_kind_of Array
      end

      it do
        expect(Bot2ch::Menu.get_boards(/ff/)).to be_all{ |board| board.is_a?(Bot2ch::Board) }
      end
    end
  end

  describe ".category" do
    it do
      expect(Bot2ch::Menu.category("ニュース")).to be_a_kind_of Array
    end

    it do
      expect(Bot2ch::Menu.category("ニュース")).to be_all{ |board| board.kind_of?(Bot2ch::Board) }
    end
  end

  describe ".categories" do
    it do
      expect(Bot2ch::Menu.categories).to be_a_kind_of Array
    end
  end
end
