module Bot2ch::Shitaraba
  class Board < Bot2ch::Board
    def reload
      Bot2ch::Helper.make_array_of_response(Bot2ch::Client.get(@subject)).map do |line|
        dat, title = line.split("cgi,", 2)
        Thread.new(dat_url(dat), title)
      end
    end

    private

    def dat_url(dat)
      url = URI.parse(@url)
      url.path = "/bbs/rawmode.cgi#{url.path}#{dat}"
      url.to_s
    end
  end
end
