module Bot2ch::
  class NormalImageDownloader < Downloader
    def download(saveTo)
      http = Net::HTTP.new(uri.host, 80)
      res = http.get(uri.path)
      save(res, saveTo)
    end

    def self.match(url)
      url =~ /.jpg$/i
    end
  end
end
