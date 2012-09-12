require 'rspec'
require 'webmock/rspec'
require 'splunker'
require 'rspec_let_definitions'

RSpec.configure do |config|
  config.color_enabled = true
  config.formatter     = 'documentation'
  config.include Splunker::RspecLetDefinitions
  config.include WebMock::API
end

def fixture(file)
  File.new( File.expand_path('../fixtures', __FILE__) + "/" + file)
end

def basic_auth_resource_builder(client, resource)
  path = client.resource_builder(resource)
  endpoint = client.configuration[:endpoint]
  endpoint.gsub!("https://", "https://#{client.configuration[:username]}:#{client.configuration[:password]}@")

  "#{endpoint}#{path}"
end

def stub_basic_auth_request(client, resource, method=:get)
  uri = basic_auth_resource_builder(client,resource)
  stub_request(method, uri)
end

def stub_http_error(client, code, method=:get)
  stub_basic_auth_request(client, "error/#{code}", method).to_return(:status => code)
end

def stub_fixture(client, resource, fixture_file, options={:method => :get, :status=>200, :parameters => {},
                   :post_data => {}})
  code = (options[:status] || 200)
  method = (options[:method] || :get)
  stub_basic_auth_request(client, resource, method).to_return(:status => code,
    :body => fixture(fixture_file))
end
