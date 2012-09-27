require 'spec_helper'

describe Splunker::Models::Search::Job do
  let(:resource) do
    Splunker::Models::Search::Job
  end

  let(:job_fixture) do
    Nokogiri::XML(fixture("job_mysearch.xml"))
  end

  let(:job) do
    resource.new(job_fixture)
  end

  # Covered in finders_spec, but I'm feeling redundant this morning. 
  context "searching" do
    before(:each) do
      object_path = "search/jobs/MyFinderTestJob"
      resource.client.stub(:get).with(object_path, {}).and_return(job_fixture)
    end

    it "should find by id by default" do
      a = resource.find("MyFinderTestJob", {})
      a.should be_a(Splunker::Models::Search::Job)
      a.title.should eq("search index")
    end
  end

  context "loads sid" do
    let(:job) do
      resource.new(job_fixture)
    end

    it "should have an sid" do
      job.sid.should eq("mysearch")
    end
  end

  context "subresources" do
    let(:results_resource) do
      Splunker::Models::Search::Results
    end

    let(:results_job_fixture) do
      Nokogiri::XML(fixture("search_results_from_job.xml"))
    end


    before(:each) do
      object_path = "search/jobs/mysearch/results"
      resource.client.stub(:get).with(object_path, {}).and_return(results_job_fixture)
    end

    it "should load results" do
      r = job.results
      r.should be_a(Splunker::Models::Search::Results)
      r.meta.should_not be_nil
      r.results.first["median(time_total)"].should eq("280")
    end
  end
end
