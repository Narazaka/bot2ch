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
      @dat = Thread.dat?(url) ? url : Thread.url_to_dat(url)
      @title = title.strip if title
    end

    def url
      list = @dat.split('/').reject{|f| f == ''}
      "http://#{list[1]}/test/read.cgi/#{list[2]}/#{list[4][/\d+/]}/"
    end

    def posts
      @posts ||= reload
    end

    def reload
      @posts = Client.get(@dat).map.with_index(1) do |line, index|
        post = Post.new
        name, email, _date, body = line.split('<>')
        next unless _date =~ /\d/
        date = Time.local(*_date.scan(/\d+/)[0..5]) rescue next
        id = _date.scan(/ID:(.*)$/).flatten.first
        %w{name email date id body index}.each{ |key|
          eval "post.#{key} = #{key}"
        }
        post.thread = self
        post
      end.compact
    end

    def dat_no
      File.basename(@dat, '.dat')
    end

    def ita
      @dat.split("/")[3]
    end

    def title_body
      parse_title.first
    end

    def posts_count
      parse_title.last
    end

    def ikioi
      posts_count / (Time.now - start_time).round * 24
    end

    def start_time
      Time.at(dat_no.to_i)
    end

    private

    def parse_title
      if @title =~ /^(.+)\s\((\d+?)\)$/
        [$1, $2.to_i]
      end
    end
  end
end
