module Bot2ch
  class NormalImageDownloader < Downloader

    def to_s
      @url
    end

    def download(saveTo)
      http = Net::HTTP.new(uri.host, 80)
      res = http.get(uri.path)
      save(res, saveTo)
    end

    def self.match(url)
      url =~ /.#{EXTENSIONS}$/i
    end
  end
end
