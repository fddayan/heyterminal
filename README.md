# Heyterminal

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/heyterminal`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'heyterminal'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install heyterminal

## Usage

create `heyterminal.rb` file in `$HOME` directory or current directory

```
Hey(<EXPRESION>) do |arg1, arg2}
  ....execute code
end
```

`<EXPRESSION>` is using [cucumber-expression](https://github.com/cucumber/cucumber-expressions).

You can use expression or regex. Look at that documentation. Matching arguments are passed to the block.

```ruby
Hey("deploy {projectName} to heroku") do |name|
  dir_path = home_file_path "projects", name
  chdir(dir_path) do
    run "git push main heroku"
    run "heroku run rake db:migrate"
  end
end
```

You can use any ruby code and ruby gem in `heyterminal.rb`, but this command are available to make life easier.

### Commands available

* run(*args)
* capture(*args)
* chdir(*args)
* home_file_path(*args)


### Bash aliases

I suggest you create the following bash alias and function

```
function hey { heyterminal run "$*"; }

alias ht="heyterminal"
```

Now you can do

`hey deploy fancyproject to heroku`

without `"`

also you can use

`ht list`


### Execution

`heyterminal run "deploy fancyproject to heroku"`

```
Commands:
  heyterminal edit                       # Edit heytermianl.rb
  heyterminal list                       # Lists all commands
  heyterminal run [COMMAND]              # Runs a command
  heyterminal version                    # Print version
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/heyterminal. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Heyterminal project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/heyterminal/blob/master/CODE_OF_CONDUCT.md).
