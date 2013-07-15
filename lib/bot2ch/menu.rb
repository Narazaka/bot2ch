module Bot2ch
  class Menu
    BBS_MENU = 'http://menu.2ch.net/bbsmenu.html'
    @@menu = nil
    @@boards = []

    class << self
      def boards
        boards = menu.map do |line|
          Board.new($1) if line =~ regexp
        end
        boards.compact
      end

      def get_board(subdir)
        menu.each do |line|
          if line =~ regexp(subdir)
            if board = @@boards.find{ |board| board.url == $1 }
              return board
            else
              board = Board.new($1)
              @@boards << board
              return board
            end
          end
        end
        raise ArgumentError
      end

      def reload
        @@menu = open(BBS_MENU).readlines
      end

      private

      def menu
        @@menu ? @@menu : reload
      end

      def regexp(subdir = nil)
        subdir ? /href=(.+\/#{subdir}\/)/i : /href=([^\s>"]+)/i
      end
    end
  end
end
