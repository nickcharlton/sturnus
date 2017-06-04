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
