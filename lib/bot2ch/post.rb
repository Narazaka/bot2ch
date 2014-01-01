# -*- coding: utf-8 -*-
module Bot2ch
  class Post
    attr_accessor :name, :email, :date, :body, :index, :id, :thread

    def initialize(params = {})
      params.each do |name, value|
        send("#{name}=", value)
      end
      yield self if block_given?
    end

    def url
      "#{self.thread.url}/#{self.index}"
    end

    def plain
      "#{index} : #{name}(#{email}) : #{date} ID:#{id}\n#{stripped_tag(body)}"
    end

    def block
      "#{index} : #{name}(#{email}) : #{date_2ch} ID:#{id}\n#{body}"
    end

    def date_2ch
      date.strftime("%Y/%m/%d(#{wday_ja}) %H:%M:%S.#{milli_sec}")
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

    def milli_sec
      (date.usec / 1000.0).round
    end

    WDAY_JA = %w(日 月 火 水 木 金 土)

    def wday_ja
      WDAY_JA[date.wday]
    end

    def stripped_tag(strings)
      strings.gsub("<br>", "\n").gsub(/<[^<>]*>/, "")
    end
  end
end
