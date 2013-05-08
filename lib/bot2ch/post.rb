module Bot2ch
  class Post
    attr_accessor :name, :email, :date, :body, :index, :id, :thread

    def url
      "#{self.thread.url}/#{self.index}"
    end
  end
end
