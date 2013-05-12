require "spec_helper"

describe Bot2ch::Thread do
  let(:url){ "http://ikura.2ch.net/football/dat/1366976995.dat" }
  let(:title){ "TITLE" }
  before{ @thread = Bot2ch::Thread.new(url, title) }
  subject{ @thread }

  it do
    Bot2ch::Thread.dat?(url).should be_true
  end

  its(:url) do
    should == "http://ikura.2ch.net/test/read.cgi/football/1366976995/"
  end

  its(:dat_no) do
    should == "1366976995"
  end

  its(:ita) do
    should == "football"
  end

  it "#posts" do
    VCR.use_cassette("posts") do
      @posts = @thread.posts
    end
    @posts.should be_a_kind_of(Array)
  end

  it "#images" do
    Bot2ch.enable_downloader

    VCR.use_cassette("images") do
      @images = @thread.images
    end
    @images.should be_a_kind_of(Array)
  end
end
