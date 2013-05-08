module Bot2ch
  class Menu
    BBS_MENU = 'http://menu.2ch.net/bbsmenu.html'

    def boards
      boards = open(BBS_MENU).readlines.map do |line|
        Board.new($1) if line =~ regexp
      end
      boards.compact
    end

    def get_board(subdir)
      open(BBS_MENU).readlines.each do |line|
        return Board.new($1) if line =~ regexp(subdir)
      end
    end

    private

    def regexp(subdir = nil)
      subdir ? /href=(.+#{subdir})/i : /href=([^\s>"]+)/i
    end
  end
end
