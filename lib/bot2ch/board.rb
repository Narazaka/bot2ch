module Bot2ch
  class Board
    def initialize(url)
      @url = url
      @subject = URI.join(url, "subject.txt")
    end

    def threads
      @threads ||= get_threads
    end

    def each
      threads.each{ |thread| yield thread }
    end
    include Enumerable

    private

    def get_threads
      # rails
      Bot2ch.encode(open(@subject, "r:binary").read).lines.map do |line|
        dat, title = line.chomp.split("<>")
        Thread.new("#{@url}dat/#{dat}", title)
      end
    end
  end
end
