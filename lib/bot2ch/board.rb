module Bot2ch
  class Board
    def initialize(url)
      @url = url
      @subject = URI.join(url, "subject.txt")
    end

    attr_reader :url, :subject

    def threads
      @threads ||= get_threads
    end

    def reload
      @threads = get_threads
    end

    def each
      threads.each{ |thread| yield thread }
    end
    include Enumerable

    private

    def get_threads
      puts "get_thread!"
      # rails
      Bot2ch.encode(open(@subject, "r:binary").read).lines.map do |line|
        dat, title = line.chomp.split("<>")
        Thread.new("#{@url}dat/#{dat}", title)
      end
    end
  end
end
