module Bot2ch
  module Helper
    module_function

    def make_array_of_response(response)
      if response.respond_to?(:body)
        response.body.lines.map(&:chomp)
      else
        response.lines.map(&:chomp)
      end
    end

    def source(source, caller)
      source =~ URI.regexp ? caller.class::Remote.new(source) : caller.class::Local.new(source)
    end
  end
end
