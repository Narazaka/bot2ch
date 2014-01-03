shared_examples_for "a thread" do
  describe ".dat?" do
    it do
      expect(described_class.dat?(dat)).to eq true
    end

    it do
      expect(described_class.dat?(url)).to eq false
    end
  end

  describe ".datlize" do
    it do
      expect(described_class.datlize(url)).to eq dat
    end

    it do
      expect(described_class.datlize(dat)).to eq dat
    end
  end

  describe ".urlize" do
    it do
      expect(described_class.urlize(url)).to eq url
    end

    it do
      expect(described_class.urlize(dat)).to eq url
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

  describe "#posts" do
    let(:posts) do
      VCR.use_cassette("#{described_class}-posts") do
        thread.posts
      end
    end

    it do
      expect(posts).to be_a_kind_of(Array)
    end

    it do
      post = posts.first
      [:name, :email, :date, :body, :index, :id].each do |method_name|
        expect(post.send(method_name)).to_not be_nil
      end
    end
  end
  

  describe "#title" do
    it do
      expect(thread.title).to eq title
    end
  end

  describe "#title_body" do
    it do
      expect(thread.title_body).to eq title_body
    end
  end

  describe "#posts_count" do
    it do
      expect(thread.posts_count).to eq posts_count
    end
  end

  describe "#ikioi" do
    it do
      expect(thread.ikioi).to be_a_kind_of Float
    end
  end

  describe "#start_time" do
    it do
      expect(thread.start_time).to eq Time.at(dat_no.to_i)
    end
  end
end
