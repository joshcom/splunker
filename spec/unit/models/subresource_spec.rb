require 'spec_helper'

describe Splunker::Models::Finders do
  let(:resource) do
    Splunker::Models::Search::Results
  end

  let(:search_fixture) do
    Nokogiri::XML(fixture("search_results_from_job.xml"))
  end

  before(:each) do
    object_path = "search/jobs/myjob/results"
    resource.client.stub(:get).with(object_path, {}).and_return(search_fixture)
  end

  context "retrieval" do
    it "should retrieve the subresource data" do
      r = resource.find_as_subresource("search/jobs", "myjob", "results", {})
      r.should be_a(Splunker::Models::Search::Results)
    end
  end

  context "finders" do
    it "should not allow the where method" do
      expect {
        resource.where(:me => "you")
      }.to raise_error(NoMethodError)
    end
    it "should not allow the find method" do
      expect {
        resource.find(:all)
      }.to raise_error(NoMethodError)
    end
    it "should not allow the find_all method" do
      expect {
        resource.find_all
      }.to raise_error(NoMethodError)
    end
    it "should not allow the find_by_id method" do
      expect {
        resource.find_by_id "my_resource"
      }.to raise_error(NoMethodError)
    end
  end
end

