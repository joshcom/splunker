# Splunker 

A Ruby client for the [RESTful Splunk API](http://dev.splunk.com/view/rest-api-overview/SP-CAAADP8)

Consider this largely functional but alpha.  See the TODO list below.

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

# Console
To make playing around with the API client a smooth(er) experience, you can fire up our IRB wrapper by:

    $ bundle exec script/console 
    Enabling console mode for local gem
    Loading splunker gem...
    Splunker:001:0> c = Splunker.client(:auth_mode => :http_auth)
    #<Splunker::Client:0x007f9782b0d238 @endpoint="https://localhost:8089", @app="search", @ssl_verify=true, @request_handler=#<Splunker::Auth::HttpAuth:0x007f9782b0cf68 @client=#<Splunker::Client:0x007f9782b0d238 ...>>, @password=nil, @username=nil>

# Basic Auth
    c = Splunker.client(:auth_mode => :http_auth, :username => "MYUSERNAME", 
      :password => "MYPASSWORD", :endpoint => "https://splunk.mysite.com")
    # Returns Nokogiri::XML::Document 
    # Note that /servicesNS/YOUR_USERNAME/YOUR_APPNAME is prepended automatically
    # to your resource.
    r = c.get("/saved/searches/MySearch/history")
    # Process away
    r.xpath("...")
    
## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

# TODO
* Token Auth
* Resource creation handling, blocking & polling options, with a timeout.
* Build console into gem (bin/)
