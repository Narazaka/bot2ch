module Bot2ch
  class Board
    def initialize(url)
      @url = url
      @subject = "#{url}/subject.txt"
    end

    def get_threads
      threads = []
      open(@subject) do |f|
        lines = f.read.toutf8
        lines.each do |line|
          dat, title = line.split('<>')
          threads << Thread.new("#{@url}/dat/#{dat}", title)
        end
      end
      threads
    end

    def threads
      @threads ||= get_threads
    end
  end
end
