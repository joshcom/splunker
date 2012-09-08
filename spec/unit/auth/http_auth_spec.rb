require 'spec_helper'

describe Splunker::Auth::HttpAuth do
  let(:request_handler) do
    Splunker::Auth::HttpAuth.new(client)
  end

  context "configuration" do
    it "should have a valid configuratoin if username and password are present" do
      request_handler.configuration_valid?.should be_true
    end

    it "should have an invalid configuration if either username or password are missing" do
      request_handler.stub(:configuration).and_return({})
      request_handler.configuration_valid?.should be_false

      request_handler.stub(:configuration).and_return({:username => "tido"})
      request_handler.configuration_valid?.should be_false

      request_handler.stub(:configuration).and_return({:password => "12345"})
      request_handler.configuration_valid?.should be_false
    end

    it "should raise an error when verifying configuration if invalid" do
      request_handler.verify_configuration!
      request_handler.stub(:configuration_valid?).and_return(false)
      expect {
        request_handler.verify_configuration!
      }.to raise_error(Splunker::Errors::ConfigurationError)
    end
  end

  context "connection handling" do
    before(:all) do
      @fake_connection = HttpAuthSpecConnection.new
    end

    it "should decorate a connection object with basic auth credentials" do
      request_handler.authenticate_connection(@fake_connection)
      @fake_connection.username.should eq("tido")
    end

    it "should not reconfigure a configured connection" do
      request_handler.authenticate_connection(@fake_connection) # Configure with "tido"

      request_handler.stub(:configuration).and_return({:username => "Ned", :password => "abcdefg"})
      request_handler.authenticate_connection(@fake_connection)
      @fake_connection.username.should eq("tido")
    end

    it "should reconfigure a configured connection after resetting" do
      request_handler.authenticate_connection(@fake_connection) # configure with "tido"

      request_handler.stub(:configuration).and_return({:username => "Ned", :password => "abcdefg"})
      request_handler.reset  
      request_handler.authenticate_connection(@fake_connection)
      @fake_connection.username.should eq("Ned")
    end
  end
end

class HttpAuthSpecConnection
  attr_accessor :username, :password
  def basic_auth(username, password)
    self.username = username
    self.password = password
  end
end
