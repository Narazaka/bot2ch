class Faraday::Response
  class SjisToUTF8 < Faraday::Response::Middleware
    def call(env)
      @app.call(env).on_complete do
        content_type = env[:response_headers]["content-type"].split(";").first
        if %w(text/plain text/html).include?(content_type)
          env[:body] = scrub(env[:body]).encode("UTF-8")
        end
      end
    end

    private

    def scrub(strings)
      strings
        .encode("UTF-16BE", "SHIFT_JIS", :invalid => :replace, :undef => :replace, :replace => '')
    end
  end
end
