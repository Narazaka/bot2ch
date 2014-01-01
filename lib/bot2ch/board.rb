module Bot2ch
  class Board
    def initialize(url, name = nil)
      @url, @name = url, name
      @subject = URI.join(url, "subject.txt")
    end

    attr_reader :url, :subject, :name, :response

    def directory
      @url.split("/").last
    end

    def threads
      @threads ||= reload
    end

    def reload
      @response = Client.get(@subject)
      Bot2ch::Helper.make_array_of_response(@response).map do |line|
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
