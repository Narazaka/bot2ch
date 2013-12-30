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
          Board.new($1, $2) if line =~ /<A\sHREF=([^>\s]+)>(.+)<\/A>/
        end.compact
      end

      def get_board(subdir)
        menu.each do |board|
          return board if board.url =~ /#{Regexp.quote(subdir)}/
        end
        raise ArgumentError
      end
    end
  end
end
