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
      open(@subject, "r:sjis").readlines.map do |line|
        dat, title = line.split("<>")
        Thread.new("#{@url}/dat/#{dat}", Bot2ch.encode(title))
      end
    end
  end
end
