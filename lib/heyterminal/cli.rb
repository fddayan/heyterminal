require "dry/cli"

module Heyterminal
  module Cli
    module Commands
      extend Dry::CLI::Registry

      class Version < Dry::CLI::Command
         desc "Print version"

         def call(*)
           puts Heyterminal::VERSION
         end
      end

      class Run < Dry::CLI::Command
        desc "Runs a command"

        argument :command, desc: "Command to run"
        option :config, type: :string, default: nil, desc: "HeyTerminal cofiguration file"

         # example [
         #   "             # Prints 'wuh?'",
         #   "hello, folks # Prints 'hello, folks'"
         # ]

         def call(command: nil, **options)
           if command.nil?
             puts "command is required"
             exit 2
           else
             puts Heyterminal::Runner.lod_and_run(nil, command)
           end
         end
      end

      class List < Dry::CLI::Command
        desc "Lists all commands"

        option :config, type: :string, default: nil, desc: "HeyTerminal cofiguration file"

        def call(**options)
           Heyterminal::Runner.load_default(nil)
           list = Heyterminal::Runner.expressions_commands

           puts "List of commands"
           puts "-----------------"
           list.each do |exp|
             puts "* #{exp}"
           end
        end
      end

      class Edit < Dry::CLI::Command
        desc "Edit heytermianl.rb"

        option :config, type: :string, default: nil, desc: "HeyTerminal cofiguration file"

        def call(**options)
           Heyterminal::Runner.load_default(nil)

           line = Terrapin::CommandLine.new("#{Heyterminal::Runner.editor} #{Heyterminal::Runner.file_path}")

           line.run
        end
      end

     register "version", Version, aliases: ["v", "-v", "--version"]
     register "run",    Run
     register "list",   List
     register "edit",   Edit
      # register "start",   Start
      # register "stop",    Stop
      # register "exec",    Exec
      #
      # register "generate", aliases: ["g"] do |prefix|
      #  prefix.register "config", Generate::Configuration
      #  prefix.register "test",   Generate::Test
      # end
    end
  end
end
