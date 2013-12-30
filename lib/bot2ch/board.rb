module Bot2ch
  class Board
    def initialize(url, name = nil)
      @url = url
      @name = nil
      @subject = URI.join(url, "subject.txt")
    end

    attr_reader :url, :subject

    def threads
      @threads ||= reload
    end

    def reload
      Client.get(@subject).map do |line|
        dat, title = line.split("<>")
        Thread.new("#{@url}dat/#{dat}", title)
      end
    end

    def each
      threads.each{ |thread| yield thread }
    end
    include Enumerable
  end
end
