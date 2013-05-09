module Bot2ch
  class ImepitaDownloader < Downloader
    def download(saveTo)
      http = Net::HTTP.new(uri.host, 80)
      headers = {'Referer' => url}
      res = http.get("/image#{uri.path}", headers)
      save(res, saveTo)
    end

    def self.match(url)
      url =~ /\/\/imepita.jp\/\d+\/\d+/i
    end
  end
end
