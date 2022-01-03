module Heyterminal
  class CliCommand < Dry::CLI::Command

    def safe_call
      yield
    rescue Heyterminal::Error => e
      puts Rainbow(e.message).red
      exit 2
    end
  end
end