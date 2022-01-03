module Heyterminal
  module Cli
    module Commands
      extend Dry::CLI::Registry

      class Version < Heyterminal::CliCommand
         desc "Print version"

         def call(*)
           puts Heyterminal::VERSION
         end
      end

      class Run < Heyterminal::CliCommand
        desc 'Runs a command'

        argument :command, desc: 'Command to run'
        option :config, type: :string, default: nil, desc: 'Heyterminal cofiguration file'

        def call(command: nil, **options)
          safe_call do
            raise Heyterminal::Error, 'command is required' if command.nil?

            puts Heyterminal::Runner.lod_and_run(options.fetch(:config, nil), command)
          end
        end
      end

      class List < Heyterminal::CliCommand
        desc 'Lists all commands'

        option :config, type: :string, default: nil, desc: 'Heyterminal cofiguration file'

        def call(**options)
          safe_call do
           Heyterminal::Runner.load_default(options.fetch(:config, nil))
           list = Heyterminal::Runner.expressions_commands

           puts 'List of commands'
           puts '-----------------'
           list.each do |exp|
             puts "* #{exp}"
           end
          end
        end
      end

      class Edit < Heyterminal::CliCommand
        desc 'Edit heytermianl.rb'

        option :config, type: :string, default: nil, desc: 'Heyterminal cofiguration file'

        def call(**options)
          safe_call do
           Heyterminal::Runner.load_default(options.fetch(:config, nil))

           line = Terrapin::CommandLine.new("#{Heyterminal::Runner.editor} #{Heyterminal::Runner.file_path}")

           line.run
          end
        end
      end

      register 'version', Version, aliases: ['v', '-v', '--version']
      register 'run',    Run
      register 'list',   List
      register 'edit',   Edit
    end
  end
end
