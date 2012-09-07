require 'spec_helper'

describe Splunker::Client do
  context "initialization" do
    it "should be configurable" do
      client.endpoint.should eq("https://127.0.0.1")
    end
  end

  context "requests" do
    it "should pass methods to request handler" do 
      expect {
        client.get
      }.to raise_error ArgumentError
    end

    it "should respond to methods handled by request handler" do
      client.respond_to?(:get).should be_true
    end
  end
end
