# GenBrain

Generate subspecies of brainf*ck.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'gen_brain'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install gen_brain

## Usage

There are sample files. Write the folowing yaml file in your current directory.

- config.yml
- config_kemofure.config
- config_street_fighter2.config

And execute.
Then, A brainfuck subspecific language and a sample file to output "Hello world!" are generated.

```
$ gen_brain config_kemofure.config
⭐️ Input config file nam #=> config_kemofure.config
🎉 Created brain_kemofure.rb and brain_kemofure_hello_world
🌈 Let's execute the following code!!
#=> ruby brain_kemofure.rb brain_kemofure_hello_world
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/284km/gen_brain. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the GenBrain project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/284km/gen_brain/blob/master/CODE_OF_CONDUCT.md).
