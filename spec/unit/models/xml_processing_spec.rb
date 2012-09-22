require 'spec_helper'

describe Splunker::Models::XmlProcessing do
  include Splunker::Models::XmlProcessing

  let(:xml) do
    Nokogiri::Slop(fixture("saved_search.xml"))
  end

  it "should return a current node if not top-node is found" do
    node = top_node(xml)
    node.xpath("xmlns:title").text.should eq("savedsearch")   
  end

  it "should return the feed node if available" do
    entry = Nokogiri::XML(xml.xpath("//xmlns:entry").to_xml)
    node = top_node(entry)
    node.xpath("title").text.should eq("MySavedSearch")   
  end

  it "should return the entry node if no feed is found" do
    entry = Nokogiri::XML(xml.xpath("//xmlns:author").to_xml)
    node = top_node(entry)
    node.text.strip.should eq("Splunk")
  end
end
