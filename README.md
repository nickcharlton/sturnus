# Sturnus

Sturnus is a client library for the [Starling Bank][] [API][].

[Starling Bank]: https://starlingbank.com
[API]: https://developer.starlingbank.com

## Installation

Add this line to your application's Gemfile:

```ruby
gem "sturnus"
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sturnus

## Usage

Starling uses [OAuth2][] for authentication. There's two endpoints (production
and a sandbox) using the full flow and [personal access tokens][] which allow
you to create tokens for your own account, bypassing the redirects.

### Standard OAuth2

After creating an application (in either sandbox or production), set the
`client_id`, `client_secret`, and `redirect_uri`. Optionally, set
`environment` (which defaults to `:production`.)

```ruby
Sturnus.configure do |config|
  config.environment = :sandbox #=> :production
  config.client_id = ""
  config.client_secret = ""
  config.redirect_uri = ""
end
```

`Starnus::Client` wraps the [`oauth2` gem][gem] and provides a few methods to
help:

```ruby
client = Starnus.client
client.authorize_url # to redirect to
client.exchange_token(code) # from the post you got back
```

You can pull the configured client object out from `Starnus.client`, then
generate the URL to redirect which the user will be redirected to (using
`authorize_url`), followed by getting an access token using the code which came
back (`exchange_token`). The token will be used from this point onwards.

### Personal Access Tokens

After creating a [personal access token][], pass this into the `configure`
block directly:

```ruby
Sturnus.configure do |config|
  config.access_token = "YOUR_TOKEN"
end
```

You won't need to set `environment`, `client_id`, `client_secret` or
`redirect_uri`.

[OAuth2]: https://tools.ietf.org/html/rfc6749
[gem]: https://github.com/intridea/oauth2
[personal access token]: https://developer.starlingbank.com/token/new
[personal access tokens]: https://developer.starlingbank.com/token/new

### Working with Resources

The `client` is now configured to allow you to fetch different resources:

```ruby
client.get("/api/v1/me")
# => {"customerUid":"18c0cf35...","authenticated":true,"expiresInSeconds":0...}
```

But it's nicer to work with objects and not JSON so you can fetch resources
directly and it'll build an object from the response:

```ruby
customer = Sturnus::Customer.get
customer.uid #=> 18c0cf35...
customer.first_name #=> Dirk
# etc
```

This is done by using [representable][]. As a general rule, duplication of
names is lost (`customerUid` becomes `uid`) and `snake_case` is preferred over
`CamelCase` (`firstName` becomes `first_name`).

[representable]: http://trailblazer.to/gems/representable

### Following Links

Each of the resource objects support the `_links` attribute in the response and
can follow them (including unpacking into the correct `Sturnus::Resource`
subclass. For example:

```ruby
customer = Sturnus::Customer.get
customer._links["self"].get #=> #<Sturnus::Customer:0x007f8326a93cf0 @_links=..
```

When the original resource is parsed, each of the links becomes a `Hyperlink`
object which can determine the correct resource (through the URL) through a
lookup table (`Sturnus.models`).

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then,
run `rake spec` to run the tests. You can also run `bin/console` for an
interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.
To release a new version, update the version number in `version.rb`, and then
run `bundle exec rake release`, which will create a git tag for the version,
push git commits and tags, and push the `.gem` file to
[rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/nickcharlton/sturnus.

This project is intended to be a safe, welcoming space for collaboration, and
contributors are expected to adhere to the [Contributor
Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of
the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Sturnus project’s codebases, issue trackers,
chat rooms and mailing lists is expected to follow the [code of
conduct](https://github.com/nickcharlton/sturnus/blob/master/CODE_OF_CONDUCT.md).
