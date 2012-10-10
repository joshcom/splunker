require 'spec_helper'

describe Splunker::Models::Search::History do
  
  let(:resource_fixture) do
    Nokogiri::XML(fixture("saved_history.xml"))
  end

  context "initialization" do
    let(:history) do
      Splunker::Models::Search::History.new(resource_fixture)
    end

    it "should load history" do
      history.title.should eq("scheduler__wade__search__50msclub_at_1349890200_9c17278833a16531")
      history.published.should eq("2012-10-10T12:30:32-05:00")
    end
  end
end
