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
    it do
      expect(@thread.url).to eq "http://ikura.2ch.net/test/read.cgi/football/1366976995/"
    end
  end

  describe '#dat_no' do
    it do
      expect(@thread.dat_no).to eq "1366976995"
    end
  end

  describe '#ita' do
    it do
      expect(@thread.ita).to eq "football"
    end
  end

  describe "#posts" do
    it do
      VCR.use_cassette("posts") do
        @posts = @thread.posts
      end
      expect(@posts).to be_a_kind_of(Array)
    end
  end
end
