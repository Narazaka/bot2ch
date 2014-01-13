# -*- coding: utf-8 -*-
module Bot2ch
  class Menu
    BBS_MENU = 'http://menu.2ch.net/bbsmenu.html'

    class << self
      attr_reader :response

      def menu
        @menu ||= reload
      end

      def reload
        @response = Client.get(BBS_MENU)
        category = nil
        boards = Bot2ch::Helper.make_array_of_response(@response).map do |line|
          category = $1 if line =~ /<B>(.+)<\/B>/
          Board.new($1, $2, category) if line =~ /<A\sHREF=([^>\s]+)>(.+)<\/A>/
        end
        boards.compact.reject{ |board| board.name == "2ch総合案内" }
      end

      def get_board(directory)
        raise ArgumentError unless board = get_boards(directory).first
        board
      end
      alias board get_board

      def get_boards(directory = nil)
        return menu unless directory
        menu.select do |board|
          ![board.directory, board.name].grep(directory).empty?
        end
      end
      alias boards get_boards

      def category(category)
        menu.select{ |board| board.category === category }
      end

      def categories
        menu.map(&:category).compact.uniq
      end
    end
  end
end
