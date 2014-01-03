require "spec_helper"

describe Bot2ch::Shitaraba::Thread do
  context "when Remote" do
    let(:thread) do
      Bot2ch::Shitaraba::Thread.new(url, title)
    end

    let(:url){ "http://jbbs.shitaraba.net/bbs/read.cgi/#{ita}/#{dat_no}/" }
    let(:dat){ "http://jbbs.shitaraba.net/bbs/rawmode.cgi/#{ita}/#{dat_no}/" }
    let(:title){ "#{title_body} (#{posts_count})" }

    let(:title_body){ "TITLE" }
    let(:posts_count){ 32 }

    let(:ita){ "computer/34346" }
    let(:dat_no){ "1384431394" }

    it_behaves_like "a thread" do
      let(:described_class){ Bot2ch::Shitaraba::Thread }
    end
  end

  context "when Local" do

  end
end
