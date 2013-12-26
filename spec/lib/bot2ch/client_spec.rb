require "spec_helper"

describe Bot2ch::Client do
  describe "instance methods" do
    before do
      @client = Bot2ch::Client.instance
    end

    it "is singleton" do
      expect{ Bot2ch::Client.new }.to raise_error
    end

    describe "#get" do
      let(:response) do
        VCR.use_cassette "crawler.get" do
          @client.get("http://ikura.2ch.net/football/")
        end
      end
      
      it do
        expect(response).to be_a_kind_of Faraday::Response
      end
      
      it do
        expect(response.body.encoding.name).to eq "UTF-8"
      end
    end

    describe "#config" do
      before do
        @client.config do |client|
          client.headers["Referer"] = "user agent"
        end
      end

      it do
        referer = @client.instance_eval{ @client.headers["Referer"] }
        expect(referer).to eq "user agent"
      end
    end
  end
end
