require 'spec_helper'

describe Splunker::Client do
  context "initialization" do
    it "should be configurable" do
      client.endpoint.should eq("https://127.0.0.1")
    end
  end
end
