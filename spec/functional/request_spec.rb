require 'spec_helper'
describe Splunker::Request do
  context "successful requests" do
    it "should return the response body as an Nokogiri::XML::Document" do
      stub_fixture(client, "generic/search/results/get", "search_results_from_job.xml",
                  :parameters => {:parameter1 => "OK"})
      client.get("generic/search/results/get").should be_a(Nokogiri::XML::Document)
    end

    it "should successfully perform post requests" do
      stub_fixture(client, "generic/search/results/post", "search_results_from_job.xml",
                  :method => :post, :data => {:parameter1 => "OK"})
      client.post("generic/search/results/post", :parameter1 => "OK").should be_a(Nokogiri::XML::Document)
    end
  end

  context "authentication" do # TODO: Once we have token_auth in place.
    it "should not authenticate unless needed" do
    end
    it "should authenticated if needed" do
    end
    it "should retry authentication once if a 401 is returned" do
    end
  end

  context "http errors" do
    it "should raise a mapped exception with a known HTTP error" do
      stub_http_error(client, 405)
      expect {
        client.get("error/405")
      }.to raise_error Splunker::Errors::MethodNotAllowedError
    end
    it "should raise a client error with an unknown status code" do
      stub_http_error(client, 499)
      expect {
        client.get("error/499")
      }.to raise_error Splunker::Errors::ClientError
    end
  end
end
