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
    # Note that /servicesNS/YOUR_USERNAME/YOUR_APPNAME is prepended automatically
    # to your resource.
    r = c.get("/saved/searches/MySearch/history")
    # Process away
    r.xpath("...")
    
## Exceptions

The API client raises an exception when a non-2XX [response codes](http://docs.splunk.com/Documentation/Splunk/latest/RESTAPI/RESTusing#Response_status) is received.

<table>
  <thead>
    <tr>
      <th>HTTP Code</th>
      <th>Spark API Error Code</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>401</td>
      <td>Splunker::Errors::AuthenticationFailureError</td>
    </tr>
    <tr>
      <td>402</td>
      <td>Splunker::Errors::FeatureDisabledError</td>
    </tr>
    <tr>
      <td>403</td>
      <td>Splunker::Errors::PermissionDeniedError</td>
    </tr>
    <tr>
      <td>404</td>
      <td>Splunker::Errors::ObjectDoesNotExistError</td>
    </tr>
    <tr>
      <td>405</td>
      <td>Splunker::Errors::MethodNotAllowedError</td>
    </tr>
    <tr>
      <td>409</td>
      <td>Splunker::Errors::InvalidOperationError</td>
    </tr>
    <tr>
      <td>500</td>
      <td>Splunker::Errors::InternalServerError </td>
    </tr>
    <tr>
      <td>Any other non-2xx response</td>
      <td>Splunker::Errors::ClientError</td>
    </tr>
  </tbody>
</table>

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
