class Faraday::Response
  class SjisToUTF8 < Faraday::Response::Middleware
    def call(env)
      @app.call(env).on_complete do
        env[:body] = scrub(env[:body]).encode("UTF-8")
      end
    end

    private

    def scrub(strings)
      strings
        .encode("UTF-16BE", "SHIFT_JIS", :invalid => :replace, :undef => :replace, :replace => '')
    end
  end
end
