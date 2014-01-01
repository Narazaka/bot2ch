require "faraday"
require "faraday_middleware"
require "faraday/response/encoder"
require "singleton"

module Bot2ch
  class Client
    include Singleton

    class << self
      def get(url, headers = {}, &block)
        client = Client.instance
        client.headers = headers
        client.config(&block) if block_given?
        client.get(url)
      end
    end

    def initialize
      options = { from: "Shift_JIS", to: "UTF-8", text_only: true, replace: "",
        if: ->(env){ env[:url].to_s =~ %r(\Ahttp://[^\/]+\.2ch\.net/) } }
      shitaraba_options = { from: "EUC-JP", to: "UTF-8", text_only: true, replace: "",
        if: ->(env){ env[:url].to_s =~ %r(\Ahttp://jbbs\.shitaraba\.net/) } }
      @client = Faraday.new do |builder|
        builder.response :encoder, options
        builder.response :encoder, shitaraba_options
        builder.use FaradayMiddleware::FollowRedirects, limit: 3
        builder.use Faraday::Response::RaiseError
        builder.adapter :net_http
      end
    end

    def headers=(headers)
      @client.headers.merge!(headers)
    end

    def config(&block)
      @client.instance_eval(&block)
    end

    def get(url, headers = {})
      self.headers = headers
      @client.get(url)
    end
  end
end
