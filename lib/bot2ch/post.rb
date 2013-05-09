module Bot2ch
  class Post
    attr_accessor :name, :email, :date, :body, :index, :id, :thread

    def url
      "#{self.thread.url}/#{self.index}"
    end

    def plain
      "#{index} : #{name}(#{email}) : #{date} ID:#{id}\n#{body}"
    end

    def replies
      @replies ||= parse_replies
    end

    def has_replies?
      !replies.empty?
    end

    private

    def parse_replies
      self.thread.posts.select do |post|
        post.body =~ /&gt;&gt;#{self.index}/
      end
    end
  end
end
