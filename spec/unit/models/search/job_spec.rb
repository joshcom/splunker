require 'spec_helper'

describe Splunker::Models::Search::Job do
  let(:resource) do
    Splunker::Models::Search::Job
  end

  let(:job_fixture) do
    Nokogiri::XML(fixture("job_mysearch.xml"))
  end

  # Covered in finders_spec, but I'm feeling redundant this morning. 
  context "searching" do
    before(:each) do
      object_path = "jobs/MyFinderTestJob"
      resource.client.stub(:get).with(object_path).and_return(job_fixture)
    end

    it "should find by id by default" do
      a = resource.find("MyFinderTestJob")
      a.should be_a(Splunker::Models::Search::Job)
      a.title.should eq("search index")
    end
  end
end
