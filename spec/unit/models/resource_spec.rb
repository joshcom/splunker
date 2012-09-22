require 'spec_helper'

describe Splunker::Models::Resource do
  include Splunker::Models

  let(:model) do
    xml = Nokogiri::XML(fixture("saved_search.xml"))
    Splunker::Models::Resource.new(xml)
  end

  it "should reference a client" do
    model.class.client.should be_a(Splunker::Client)
  end

  it "should act on attribute methods" do
    model.title.should eq("MySavedSearch")
  end

  it "should write to attributes through assignment methods" do
    model.title = "josh's search"
    model.title.should eq("josh's search")
  end

  it "should respond to attribute methods" do
    model.respond_to?(:updated).should be_true
  end

  it "should not respond to missing methods" do
    model.respond_to?(:fake_method).should be_false
  end

  it "should raise a NoMethodError when accessing missing methods" do
    expect {
      model.fake_method
    }.to raise_exception NoMethodError
  end

end
