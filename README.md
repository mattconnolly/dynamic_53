# Dynamic53

A simple tool to update Amazon Route 53 with based on your current IP Address.

Requirements:

* An amazon account with a zone created in route 53.
* AWS credentials with access to update Route 53.
* Access to internet. :)

## Installation

Add this line to your application's Gemfile:

    gem 'dynamic_53'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dynamic_53

## Usage

Run the command as following:

    $ dynamic_53 -z example.com. -h dynamic.example.com.

This will update the host "dynamic.example.com." within the route 53 zone "example.com." with you current IP address.

Note that AWS credentials are expected to be provided in the environment variables `AWS_ACCESS_KEY_ID` and
`AWS_SECRET_ACCESS_KEY`. Refer to Amazon Web Services console to create a user with the credentials to make updates
in Route 53.

## Development

Use `rake` to run tests.

## Contributing

1. Fork it ( http://github.com/<my-github-username>/dynamic_53/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
