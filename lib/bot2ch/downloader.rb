module Bot2ch
  class Downloader
    attr_accessor :uri, :url

    def initialize(url)
      @url = url
      @uri = URI.parse(@url)
    end

    def save(res, saveTo)
      puts "download: #{url}"
      case res
      when Net::HTTPSuccess
        open(saveTo, 'wb') do |f|
          f.write res.body
        end
      end
    end
  end
end
