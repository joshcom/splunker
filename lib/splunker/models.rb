require 'splunker/models/resource'
Dir[File.dirname(__FILE__) + '/models/*/*.rb'].each do |file| 
  require file 
end
