require "spec_helper"

describe Bot2ch::Thread do
  let(:url){ "http://ikura.2ch.net/football/dat/1366976995.dat" }
  let(:title){ "TITLE" }
  before{ @thread = Bot2ch::Thread.new(url, title) }

  it do
    VCR.use_cassette("posts") do
      @posts = @thread.posts
    end
    @posts.should be_a_kind_of(Array)
  end
end
