require 'spec_helper'

describe Splunker::Models::Search::Job do
  let(:resource) do
    Splunker::Models::Search::Results
  end

  let(:job_fixture) do
    Nokogiri::XML(fixture("search_results_from_job.xml"))
  end

  context "initialization" do
    let(:results) do
      resource.new(job_fixture)
    end

    it "should load top level attributes" do
      results.meta.should_not be_nil
      results.results.first["median(time_total)"].should eq("280")
    end
  end
end
