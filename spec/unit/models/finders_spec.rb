require 'spec_helper'

describe Splunker::Models::Finders do
  let(:resource) do
    Splunker::Models::Search::Saved
  end

  let(:search_fixture) do
    Nokogiri::XML(fixture("saved_search.xml"))
  end

  before(:each) do
    object_path = "saved/searches/MyFinderTestSavedSearch"
    resource.client.stub(:get).with(object_path).and_return(search_fixture)
  end

  it "should find_by_id" do
    a = resource.find_by_id("MyFinderTestSavedSearch")
    a.should be_a(Splunker::Models::Search::Saved)
    a.title.should eq("MySavedSearch")
  end

  it "should find by id by default" do
    a = resource.find("MyFinderTestSavedSearch")
    a.should be_a(Splunker::Models::Search::Saved)
    a.title.should eq("MySavedSearch")
  end
end

