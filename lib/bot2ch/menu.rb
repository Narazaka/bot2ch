module Bot2ch
  class Menu
    BBS_MENU = 'http://menu.2ch.net/bbsmenu.html'

    class << self
      def boards
        boards = menu.readlines.map do |line|
          Board.new($1) if line =~ regexp
        end
        boards.compact
      end

      def get_board(subdir)
        menu.readlines.each do |line|
          return Board.new($1) if line =~ regexp(subdir)
        end
        raise ArgumentError
      end

      def reload
        @menu = open(BBS_MENU)
      end

      private

      def menu
        @menu ||= open(BBS_MENU)
      end

      def regexp(subdir = nil)
        subdir ? /href=(.+\/#{subdir}\/)/i : /href=([^\s>"]+)/i
      end
    end
  end
end
