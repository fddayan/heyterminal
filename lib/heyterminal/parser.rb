module Heyterminal
  class Parser

    def Hey(command, &block)
      expression_factory = Cucumber:: CucumberExpressions::ExpressionFactory.new(Cucumber::CucumberExpressions::ParameterTypeRegistry.new)
      add_expression [expression_factory.create_expression(command), block]
    end

    def run(*args)
      line = Terrapin::CommandLine.new(*args)
      puts "#{Rainbow("[" + line.command + "]").magenta}"
      puts line.run
    end

    def capture(*args)
      line = Terrapin::CommandLine.new(*args)
      line.run
    end

    def add_expression(expression)
      Heyterminal::Runner.add_expression(expression)
    end
  end
end
