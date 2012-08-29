require 'spec_helper'

describe "Splunker" do
  it "should create a new class if options are specified" do
    Splunker.client(:endpoint => "https://127.0.0.2").should_not be(client)
  end

  it "should reuse the existing class if no options are specified" do
    Splunker.client(:endpoint => "https://127.0.0.3").should be(Splunker.client)
  end

  it "should call methods on the client object" do
    client.configuration[:endpoint].should eq("https://127.0.0.1")
  end
end
