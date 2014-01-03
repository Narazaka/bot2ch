module Bot2ch
  class Thread
    def initialize(url, title = nil)
      @source = Bot2ch::Helper.source(url, self)
      @title = title.strip if title
    end

    attr_accessor :dat, :title, :response

    extend Forwardable
    def_delegators :@source, :get_source, :url, :dat_no, :ita

    def posts
      @posts ||= reload
    end

    def reload
      @response = get_source
      Bot2ch::Helper.make_array_of_response(@response).map.with_index(1) do |line, index|
        post = parse(line)
        if post
          Post.new(post) do |p|
            p.index = index
            p.thread = nil
          end
        end
      end.compact
    end

    def title_body
      parse_title.first
    end

    def posts_count
      parse_title.last
    end

    def ikioi
      posts_count / (Time.now - start_time) * 24
    end

    def start_time
      Time.at(dat_no.to_i)
    end

    private

    def parse(line)
      name, email, _date, body = line.split('<>')
      return unless _date =~ /\d/
      date = Time.local(*_date.scan(/\d+/)[0..5]) rescue return
      id = _date.scan(/ID:(.*)$/).flatten.first
      { name: name, email: email, date: date, body: body, id: id }
    end

    def parse_title
      [$1.strip, $2.to_i] if @title =~ /^(.+)\s*\((\d+?)\)$/
    end

    class Local
      def initialize(dat)
        @dat = dat
      end

      def get_source
        open(@dat).read
      end

      # TODO
      def url
      end

      def dat_no
        File.basename(@dat, ".*")
      end
        
      # TODO
      def ita
      end
    end

    class Remote
      class << self
        def datlize(url)
          return url if dat?(url)
          list = url.split('/')
          "http://#{list[2]}/#{list[5]}/dat/#{list[6]}.dat"
        end

        def urlize(dat)
          return dat unless dat?(dat)
          list = dat.split('/').reject{|f| f == ''}
          "http://#{list[1]}/test/read.cgi/#{list[2]}/#{list[4][/\d+/]}/"
        end

        def dat?(url)
          !!(url =~ %r[/dat/] and url =~ /\.dat$/)
        end
      end

      def initialize(url)
        @dat = self.class.dat?(url) ? url : self.class.datlize(url)
      end
      
      def get_source
        Client.get(@dat)
      end

      def url
        self.class.urlize(@dat)
      end

      def dat_no
        File.basename(@dat, '.dat')
      end

      def ita
        @dat.split("/")[3]
      end
    end
  end
end
