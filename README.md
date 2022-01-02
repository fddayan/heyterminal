# Heyterminal

This is just another tool for running command lines from the terminal. 
I was inspired by my Google Assistance to build it. 
I just wanted to say to my terminal `hey termianl do this`.
I'm currently usign it and it's proven more usefull and friendly than running `bash` scripts or other `cli` tools like `thor`.

Basically, you will need have to create a `heyterminal.rb` and that will have your commands in a DSL format in `ruby` code. (but you don't need to know `ruby`).

for example in your `heyterminal.rb` you can have :

```ruby
Hey("build and install gem project {projectName} with version {version}") do |name, version|
  dir_path = home_file_path "projects", name
  chdir(dir_path) do
    run "gem build #{name}.gemspec"
    run "gem installl #{name}-#{version}.gem"
  end
end
```

and you call that command from the terminal as follow:

`heytermianl run "build and install gem project heytermianl with version 0.1.0"`

* That changes directory to the `heyterminal` project
* Then builds the gem based on the name (`heyterminal`)
* Then installs the gem based on the name and the version

As common practice if you don't specify a `terminal.rb` file, it will search for a config file in this order 

* current directory `./heyterminal.rb`
* home directory    `~/heyterminal.rb`

if you specify a `heyterminal.rb` file passing the `-c` flag, that takes priority.

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

```ruby
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

| Command                  | Description                                         |
|--------------------------|-----------------------------------------------------|
| run(*args)               | Runs a command in the terminal, prints out the outout|
| capture(*args)           | Runs a command in the termina, does not print out the output, it returns the output instead |
| chdir(*args)             | changes directory in the termianl |               
| home_file_path(*args)    | returns a a file path based from the `$HOME` path |
| hey                      | You can call another command just as you would from the terminal"


### Bash aliases

I suggest you create the following bash `alias` and `function`

```
function hey { heyterminal run "$*"; }

alias ht="heyterminal"
```

Now you can run from the terminal:

`hey deploy fancyproject to heroku`

you don't have to specify quotes (`"`).

also you can use shorcut `nt` like:

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
