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

    def posts
      @posts ||= get_posts
    end

    def reload
      @posts = get_posts
    end

    def dat_no
      File.basename(@dat, '.dat')
    end

    private

    def get_posts
      open(@dat).readlines.map.with_index(1) do |line, index|
        line = Bot2ch.encode(line)
        post = Post.new
        name, email, _date, body = line.split('<>')
        date = Time.local(*_date.scan(/\d+/)[0..5])
        id = _date.scan(/ID:(.*)$/).flatten.first
        %w{name email date id body index}.each{ |key|
          eval "post.#{key} = #{key}"
        }
        post.thread = self
        post
      end
    end
  end
end
