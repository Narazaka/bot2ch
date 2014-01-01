module Bot2ch
  module Helper
    module_function

    def make_array_of_response(response)
      response.body.lines.map(&:chomp)
    end
  end
end
