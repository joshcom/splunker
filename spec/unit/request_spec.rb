describe Splunker::Request do
  context "assembling a path" do
    it "should strip repeated slashes" do
      client.assemble_path("//search//joshua/saved/searches").should eq("/search/joshua/saved/searches")
    end
  end

  context "building a resource path" do
    it "should assemble the path from the username and app name" do
      client.resource_builder("saved/searches").should eq("/servicesNS/tido/search/saved/searches")
    end
  end
end
