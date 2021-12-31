module Heyterminal
  class Parser

    def editor(editor)
      Heyterminal::Runner.set_editor(editor)
    end

    def Hey(command, &block)
      expression_factory = Cucumber:: CucumberExpressions::ExpressionFactory.new(Cucumber::CucumberExpressions::ParameterTypeRegistry.new)
      add_expression [expression_factory.create_expression(command), block]
    end

    def run(*args)
      line = Terrapin::CommandLine.new(*args)
      puts "#{Rainbow("[" + line.command + "]").magenta}"
      spinner = TTY::Spinner.new
      spinner.auto_spin
      output = line.run
      spinner.stop("Done!")
      puts output
    end

    def capture(*args)
      line = Terrapin::CommandLine.new(*args)
      line.run
    end

    def chdir(to, &block)
      Dir.chdir(to, &block)
    end

    def home_file_path(*args)
      File.join(Dir.home, *args)
    end

    def add_expression(expression)
      Heyterminal::Runner.add_expression(expression)
    end
  end
end
