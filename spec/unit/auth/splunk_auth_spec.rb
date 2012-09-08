require 'spec_helper'

describe Splunker::Auth::SplunkAuth do
  let(:request_handler) do
    Splunker::Auth::SplunkAuth.new(client)
  end

  context "configuration" do
    it "should not be configured by default" do
      request_handler.configured?.should be_false
    end

    it "should have access to client configuration" do
      request_handler.configuration.should be_a(Hash)
    end
    
    it "should raise exception when verifying configuration if invalid" do
      request_handler.verify_configuration!
      request_handler.stub(:configuration_valid?).and_return(false)
      expect {
        request_handler.verify_configuration!
      }.to raise_error(Splunker::Errors::ConfigurationError)
    end

    it "should have a valid configuration by default" do
      request_handler.configuration_valid?.should be_true
    end
  end
end
