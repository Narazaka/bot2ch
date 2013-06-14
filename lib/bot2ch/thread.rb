module Bot2ch
  class Thread
    class << self
      def url_to_dat(url)
        list = url.split('/')
        "http://#{list[2]}/#{list[5]}/dat/#{list[6]}.dat"
      end

      def dat?(url)
        url =~ %r[/dat/] and url =~ /\.dat$/
      end
    end

    attr_accessor :dat, :title

    def initialize(url, title = nil)
      @dat = url
      @title = title.strip if title
    end

    def url
      list = @dat.split('/').reject{|f| f == ''}
      "http://#{list[1]}/test/read.cgi/#{list[2]}/#{list[4][/\d+/]}/"
    end

    def posts
      @posts ||= get_posts
    end

    def reload
      @posts = get_posts
    end

    def dat_no
      File.basename(@dat, '.dat')
    end

    def images
      @images ||= get_images
    end

    def ita
      @dat.split("/")[3]
    end

    private

    def get_images
      images = []
      posts.each do |post|
        post.body.scan(/\/\/[-_.!~*\'()a-zA-Z0-9;\/?:\@&=+\$,%#]+/i).each do |image|
          image = "http:#{image}"
          case
          when ImepitaDownloader.match(image)
            images << ImepitaDownloader.new(image)
          when NormalImageDownloader.match(image)
            images << NormalImageDownloader.new(image)
          else
            next
          end
        end
      end
      images
    end

    def get_posts
      open(@dat, "r:sjis").readlines.map.with_index(1) do |line, index|
        line = Bot2ch.encode(line)
        post = Post.new
        name, email, _date, body = line.split('<>')
        next unless _date =~ /\d/
        date = Time.local(*_date.scan(/\d+/)[0..5])
        id = _date.scan(/ID:(.*)$/).flatten.first
        %w{name email date id body index}.each{ |key|
          eval "post.#{key} = #{key}"
        }
        post.thread = self
        post
      end.compact
    end
  end
end
