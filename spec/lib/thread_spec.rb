require "spec_helper"

describe Bot2ch::Thread do
  let(:url){ "http://ikura.2ch.net/football/dat/1366976995.dat" }
  let(:title){ "TITLE" }
  before{ @thread = Bot2ch::Thread.new(url, title) }
  subject{ @thread }

  it do
    expect(Bot2ch::Thread.dat?(url)).to be_truthy
  end

  describe '#url' do
    subject { super().url }
    it do
    should == "http://ikura.2ch.net/test/read.cgi/football/1366976995/"
  end
  end

  describe '#dat_no' do
    subject { super().dat_no }
    it do
    should == "1366976995"
  end
  end

  describe '#ita' do
    subject { super().ita }
    it do
    should == "football"
  end
  end

  it "#posts" do
    VCR.use_cassette("posts") do
      @posts = @thread.posts
    end
    expect(@posts).to be_a_kind_of(Array)
  end

  it "#images" do
    Bot2ch.enable_downloader

    VCR.use_cassette("images") do
      @images = @thread.images
    end
    expect(@images).to be_a_kind_of(Array)
  end
end
