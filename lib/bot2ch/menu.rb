module Bot2ch
  class Menu
    BBS_MENU = 'http://menu.2ch.net/bbsmenu.html'
    @@menu = nil

    class << self
      def boards
        boards = menu.map do |line|
          Board.new($1) if line =~ regexp
        end
        boards.compact
      end

      def get_board(subdir)
        menu.each do |line|
          return Board.new($1) if line =~ regexp(subdir)
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
