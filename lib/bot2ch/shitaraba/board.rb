module Bot2ch::Shitaraba
  class Board < Bot2ch::Board
    def reload
      @response = get_source
      Bot2ch::Helper.make_array_of_response(@response).map do |line|
        dat, title = line.split("cgi,", 2)
        Thread.new(dat_path(dat), title)
      end
    end

    private

    def dat_url(dat)
      url = URI.parse(@url)
      url.path = "/bbs/rawmode.cgi#{url.path}#{dat}"
      url.to_s
    end

    class Local < Bot2ch::Board::Local
      def dat_path(dat)
        dat
      end
    end

    class Remote < Bot2ch::Board::Remote
      private

      def subject
        URI.join(@url, "subject.txt").to_s
      end

      def dat_path(dat)
        "#{@url}dat/#{dat}"        
      end
    end
  end
end
