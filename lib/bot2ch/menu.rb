module Bot2ch
  class Menu
    BBS_MENU = 'http://menu.2ch.net/bbsmenu.html'

    class << self
      def menu
        @menu ||= reload
      end
      alias boards menu

      def reload
        @menu = Client.get(BBS_MENU).map do |line|
          Board.new($1) if line =~ regexp
        end.compact
        @menu.select{ |board| board.url =~ URI.regexp }
      end

      def get_board(subdir)
        menu.each do |board|
          return board if board.url =~ regexp(subdir)
        end
        raise ArgumentError
      end

      private

      def regexp(subdir = nil)
        subdir ? %r</#{subdir}/>i : /href=([^\s>"]+)/i
      end
    end
  end
end
