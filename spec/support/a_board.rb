shared_examples_for "a board" do
  it do
    expect(threads).to be_a_kind_of Array
  end

  it do
    expect(threads).to be_all{ |thread| thread.is_a? expectation }
  end
end
