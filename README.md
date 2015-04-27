# Guard::Fig

Guard::Fig helps you develop docker containers faster using [fig](http://fig.sh/) and [docker-compose](https://github.com/docker/compose)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'guard-fig'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install guard-fig

## Usage

Add the following to your Guardfile

```
guard :fig, boot2docker_start: true, build_on_start: true, command: 'fig' do
  ignore %r{\.#}
  watch %r{.*}
end
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/guard-fig/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
