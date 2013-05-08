module Bot2ch
  class Thread
    attr_accessor :dat, :title

    def initialize(url, title)
      @dat = url
      @title = title.strip
    end

    def url
      list = @dat.split('/').reject{|f| f == ''}
      "http://#{list[1]}/test/read.cgi/#{list[2]}/#{list[4].scan(/\d/)}"
    end

    def get_images
      images = []
      downloaders = [NormalImageDownloader, ImepitaDownloader]
      open(@dat) do |f|
        lines = f.read.toutf8
        lines.each do |line|
          contents = line.split('<>')[3]
          while contents =~ /\/\/[-_.!~*\'()a-zA-Z0-9;\/?:\@&=+\$,%#]+/i
            url = "http:#{$&}"
            contents = $'
            image_downloader = downloaders.find { |d| d.match(url) }
            next unless image_downloader
            images << image_downloader.new(url)
          end
        end
      end
      images
    end

    def posts
      return @posts if @contents
      index = 1
      open(@dat) do |f|
        lines = f.read.toutf8
        @posts = lines.map do |line|
          post = Post.new
          name, email, _date, body = line.split('<>')
          date = Time.local(*_date.scan(/\d+/)[0..5])
          id = _date.scan(/ID:(.*)$/).flatten.first
          %w{name email date id body index}.each{ |key|
            eval "post.#{key} = #{key}"
          }
          post.thread = self
          index += 1
          post
        end
      end
    end

    def dat_no
      File.basename(@dat, '.dat')
    end
  end
end
