module Bot2ch
  class Board
    def initialize(url, name = nil)
      @url, @name = url, name
      @source = source(@url, self)
    end

    attr_reader :name, :response

    include Bot2ch::Helper

    extend Forwardable
    def_delegators :@source, :get_source, :directory, :dat_path

    def threads
      @threads ||= reload
    end

    def reload
      @response = get_source
      make_array_of_response(@response).map do |line|
        dat, title = line.split("<>")
        Thread.new(dat_path(dat), title)
      end
    end

    class Local
      def initialize(path)
        @path = path
      end

      def get_source
        open(@path).read
      end

      def directory
        ""
      end

      def dat_path(dat)
        dat
      end
    end
    
    class Remote
      def initialize(url)
        @url = url
      end

      def get_source
        Client.get(subject)
      end

      def directory
        @url.split("/").last
      end

      def subject
        URI.join(@url, "subject.txt").to_s
      end

      def dat_path(dat)
        "#{@url}dat/#{dat}"
      end
    end
  end
end
