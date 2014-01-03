module Bot2ch::Shitaraba
  class Thread < Bot2ch::Thread
    def ita
      @dat.split("/")[-3 .. -2].join("/")
    end

    private

    def parse(line)
      index, name, email, _date, body, title, id = line.split('<>')
      return unless _date =~ /\d/
      date = Time.local(*_date.scan(/\d+/)[0..5]) rescue return
      self.title ||= title
      { index: index, name: name, email: email, body: body, id: id, date: date }
    end

    class Local < Bot2ch::Thread::Local
    end

    class Remote < Bot2ch::Thread::Remote
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
    end
  end
end
