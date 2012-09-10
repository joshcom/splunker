# Splunker 

A Ruby client for the [RESTful Splunk API](http://dev.splunk.com/view/rest-api-overview/SP-CAAADP8)

## Installation

Add this line to your application's Gemfile:

    gem 'splunker'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install splunker

## Usage

Models are on the way, but you can access resources by directly invoking the
HTTP helper methods.

# Basic Auth
    c = Splunker.client(:auth_mode => :http_auth, :username => "MYUSERNAME", 
      :password => "MYPASSWORD", :endpoint => "https://splunk.mysite.com")
    # Returns Nokogiri::XML::Document 
    r = c.get("/saved/searches/MySearch/history")
    # Process away
    r.xpath("...")
    
## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
