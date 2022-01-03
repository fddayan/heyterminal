module Heyterminal
  class CliCommand < Dry::CLI::Command

    def call(*args)
      begin
        super(**args)
      rescue Heytermianl::Error => e
        puts Rainbow('=' * 100).red
        puts Rainbow('Error').red
        puts Rainbow(e.message).red
        puts Rainbow('=' * 100).red
      end
    end
  end
end