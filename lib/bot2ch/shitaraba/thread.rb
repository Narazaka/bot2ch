module Bot2ch::Shitaraba
  class Thread < Bot2ch::Thread
    class << self
      def urlize(dat)
        return dat unless dat?(dat)
        dat.sub("rawmode.cgi", "read.cgi")
      end

      def datlize(url)
        return url if dat?(url)
        url.sub("read.cgi", "rawmode.cgi")
      end

      def dat?(url)
        !!(url =~ %r</rawmode\.cgi/>)
      end
    end

    def reload
      @posts = Bot2ch::Client.get(@dat).map.with_index(1) do |line, index|
        post = Post.new
        index, name, email, _date, body, title, id = line.split('<>')
        next unless _date =~ /\d/
        date = Time.local(*_date.scan(/\d+/)[0..5]) rescue next
        %w{index name email date id body}.each{ |key|
          eval "post.#{key} = #{key}"
        }
        self.title ||= title
        post.thread = self
        post
      end.compact
    end

    def ita
      @dat.split("/")[-3 .. -2].join("/")
    end

    def dat_no
      @dat.split("/").last
    end
  end
end
