require "dry/cli"

module Heyterminal
  module Cli
    module Commands
      extend Dry::CLI::Registry

      class Version < Heyterminal::Command
         desc "Print version"

         def call(*)
           puts Heyterminal::VERSION
         end
      end

      class Run < Heyterminal::Command
        desc "Runs a command"

        argument :command, desc: 'Command to run'
        option :config, type: :string, default: nil, desc: 'Heyterminal cofiguration file'

         def call(command: nil, **options)
           if command.nil?
             raise Heyterminal::Error, `command is required`
           else
             puts Heyterminal::Runner.lod_and_run(options.fetch(:config), command)
           end
         end
      end

      class List < Heyterminal::Command
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

      class Edit < Heyterminal::Command
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
