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

        argument :command, desc: 'Command to run'
        option :config, type: :string, default: nil, desc: 'Heyterminal cofiguration file'

         def call(command: nil, **options)
           if command.nil?
             puts "command is required"
             exit 2
           else
             puts Heyterminal::Runner.lod_and_run(options.fetch(:config), command)
           end
         end
      end

      class List < Dry::CLI::Command
        desc 'Lists all commands'

        option :config, type: :string, default: nil, desc: 'Heyterminal cofiguration file'

        def call(**options)
           Heyterminal::Runner.load_default(options.fetch(:config))
           list = Heyterminal::Runner.expressions_commands

           puts 'List of commands'
           puts '-----------------'
           list.each do |exp|
             puts "* #{exp}"
           end
        end
      end

      class Edit < Dry::CLI::Command
        desc 'Edit heytermianl.rb'

        option :config, type: :string, default: nil, desc: 'Heyterminal cofiguration file'

        def call(**options)
           Heyterminal::Runner.load_default(options.fetch(:config))

           line = Terrapin::CommandLine.new("#{Heyterminal::Runner.editor} #{Heyterminal::Runner.file_path}")

           line.run
        end
      end

      register 'version', Version, aliases: ['v', '-v', '--version']
      register 'run',    Run
      register 'list',   List
      register 'edit',   Edit
    end
  end
end
