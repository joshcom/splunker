require 'spec_helper'

describe Splunker::Models::XmlProcessor do

  let(:processor) do
    Splunker::Models::XmlProcessor
  end

  let(:xml) do
    Nokogiri::XML(fixture("saved_search.xml"))
  end

  let(:results_xml) do
    Nokogiri::XML(fixture("search_results_from_job.xml"))
  end

  context "hashify xml" do
    let(:hash) do
      processor.hashify(xml)
    end

    it "should find top level attributes" do
      hash["id"].should eq("https://localhost:8089/servicesNS/admin/search/saved/searches/MySavedSearch")
      hash["title"].should eq("MySavedSearch")
    end

    it "should process the inner dict of content" do
      hash["action"]["email"]["mailserver"].should eq("localhost")
    end
  end

  context "top node detection" do
    it "should return the feed node if available" do
      node = processor.top_node(xml)
      # TODO: I'm aware this is dumb.
      node.children.each do |n|
        if n.name == "title"  
          n.text.should eq("MySavedSearch")
          break
        end
      end
    end

    it "should return the entry node if no feed is found" do
      entry = Nokogiri::XML(xml.xpath("//xmlns:author").to_xml)
      node = processor.top_node(entry)
      node.text.strip.should eq("Splunk")
    end
  end

  context "process results xml" do
    let(:results) do
      processor.hashify(results_xml)
    end

    it "should load meta as a top level attribute" do
      results["meta"].should_not be_nil
    end

    it "should load results, with key-value pairs" do
      results["results"].first["avg(time_total)"].should eq("626.604469")
    end
  end

  context "dictionary builders" do
    it "should build a nested hash from a string in dot notation" do
      h = {
        "action" => {
          "email" => {
            "format" => "html"
          }
        }
      }

      h = processor.place_in_nested_hash("action.fun.times", "yes", h)
      h = processor.place_in_nested_hash("joshua", "murray", h)
      h["action"]["email"]["format"].should eq("html")
      h["action"]["fun"]["times"].should eq("yes")
      h["joshua"].should eq("murray")
    end

    it "should have the power of recursion with nested_hash" do
      h = {
        "action" => {
          "email" => {
            "format" => "html"
          }
        }
      }

      processor.nested_hash(["action","email","maxtime"], "5m", h)
      processor.nested_hash(["action","populate_lookup","maxresults"], 10000, h)
      processor.nested_hash(["dispatch", "buckets"], 0, h)

      h["action"]["email"]["format"].should eq("html")
      h["action"]["email"]["maxtime"].should eq("5m")
      h["action"]["populate_lookup"]["maxresults"].should eq(10000)
      h["dispatch"]["buckets"].should eq(0)
    end
  end
end
