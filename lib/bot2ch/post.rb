module Bot2ch
  class Post
    attr_accessor :name, :email, :date, :body, :index, :id, :thread

    def url
      "#{self.thread.url}/#{self.index}"
    end

    def plain
      "#{index} : #{name}(#{email}) : #{date} ID:#{id}\n#{body}"
    end

    def responses
      @responses ||= parse_response
    end

    def has_response?
      !responses.empty?
    end

    private

    def parse_response
      self.thread.posts.select do |post|
        post.body =~ /&gt;&gt;#{self.index}/
      end
    end
  end
end
