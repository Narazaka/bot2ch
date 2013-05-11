module Bot2ch
  class Downloader
    EXTENSIONS = "jpg|jpeg|gif|png"

    attr_accessor :uri, :url

    def initialize(url)
      @url = url
      @uri = URI.parse(@url)
    end

    def save(res, save_to)
      puts "download: #{url}"
      case res
      when Net::HTTPSuccess
        open(save_to, 'wb').write(res.body)
      else
        puts "error: #{url}"
      end
    end

    def download_to(dir, override = nil)
      basename = File.basename(self.url)
      FileUtils.mkdir_p(dir) unless File.exist?(dir)
      save_to = File.join(dir, basename)
      if !override and File.exist?(save_to)
        puts "already exist: #{self.url}" and return
      end
      download(save_to)
    end
  end
end
