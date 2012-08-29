describe Splunker::Configuration do
  class MyConfigurableClass
    include Splunker::Configuration
  end
  
  let(:configurable) { MyConfigurableClass.new }

  it "should set accessors" do
    configurable.respond_to?(:endpoint=).should be_true
  end

  it "should set return a default configuration" do
    configurable.reset
    configurable.configuration[:app].should eq("search")
  end

  it "should be configurable" do
    configurable.configure do |c|
      c.username = "fred" 
    end
    configurable.username.should eq("fred")
  end
end
