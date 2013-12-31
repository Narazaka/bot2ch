require "spec_helper"

describe Bot2ch::Thread do
  let(:thread) do
    Bot2ch::Thread.new(url, title)
  end

  let(:url){ "http://ikura.2ch.net/test/read.cgi/football/#{dat_no}/" }
  let(:dat){ "http://ikura.2ch.net/football/dat/#{dat_no}.dat" }
  let(:title){ "#{title_body} (#{posts_count})" }

  let(:title_body){ "TITLE" }
  let(:posts_count){ 32 }

  let(:ita){ "football" }
  let(:dat_no){ "1366976995" }

  it_behaves_like "a thread" do
    let(:described_class){ Bot2ch::Thread }
  end
end
