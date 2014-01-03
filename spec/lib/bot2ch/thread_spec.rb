require "spec_helper"

describe Bot2ch::Thread do
  let(:thread) do
    Bot2ch::Thread.new(url, title)
  end

  let(:title){ "#{title_body} (#{posts_count})" }

  let(:title_body){ "TITLE" }
  let(:posts_count){ 32 }

  let(:ita){ "football" }
  let(:dat_no){ "1366976995" }

  context "when Remote" do
    let(:url){ "http://ikura.2ch.net/test/read.cgi/football/#{dat_no}/" }
    let(:dat){ "http://ikura.2ch.net/football/dat/#{dat_no}.dat" }

    it_behaves_like "a thread" do
      let(:described_class){ Bot2ch::Thread }
    end

    describe ".dat?" do
      it do
        expect(Bot2ch::Thread::Remote.dat?(dat)).to eq true
      end

      it do
        expect(Bot2ch::Thread::Remote.dat?(url)).to eq false
      end
    end

    describe ".datlize" do
      it do
        expect(Bot2ch::Thread::Remote.datlize(url)).to eq dat
      end

      it do
        expect(Bot2ch::Thread::Remote.datlize(dat)).to eq dat
      end
    end

    describe ".urlize" do
      it do
        expect(Bot2ch::Thread::Remote.urlize(url)).to eq url
      end

      it do
        expect(Bot2ch::Thread::Remote.urlize(dat)).to eq url
      end
    end

    describe '#url' do
      it do
        expect(thread.url).to eq url
      end
    end

    describe '#dat_no' do
      it do
        expect(thread.dat_no).to eq dat_no
      end
    end

    describe '#ita' do
      it do
        expect(thread.ita).to eq ita
      end
    end
  end

  context "when Local" do
    let(:url){ "./spec/dummy/#{dat_no}.dat" }

    it_behaves_like "a thread" do
      let(:described_class){ Bot2ch::Thread }
    end

    describe '#url' do
      it do
        expect(thread.url).to be_nil
      end
    end

    describe '#dat_no' do
      it do
        expect(thread.dat_no).to eq dat_no
      end
    end

    describe '#ita' do
      it do
        expect(thread.ita).to be_nil
      end
    end
  end
end
