module Heyterminal
  class Runner

    DEFAULT_DSL_FILE_NAME = "heyterminal.rb"

    def self.set_editor(editor)
      @editor = editor
    end

    def self.editor
      @editor
    end

    def self.lod_and_run(file, command)
      @file_path = dsl_path(file)

      raise "file not found in any of directories" if file_path.nil?

      puts "Using... #{file_path}"
      load(file_path)
      run(command)
    end

    def self.dsl_path(file)
      if file.nil? || file.empty?
        file_path = File.join(Dir.pwd, "/#{DEFAULT_DSL_FILE_NAME}")

        return file_path if File.exist?(file_path)

        file_path = File.join(Dir.home, "/#{DEFAULT_DSL_FILE_NAME}")

        return file_path if File.exist?(file_path)
      end


      file_path = File.join(Dir.pwd,file)

      return file_path if File.exist?(file_path)
    end

    def self.load_default(file)
      @file_path = dsl_path(file)
      load(@file_path)
    end

    def self.file_path
      @file_path
    end

    def self.load(file)
      contents = File.read(file)
      parser = Heyterminal::Parser.new
      parser.instance_eval(contents)
      parser
    end

    def self.add_expression(expression)
      @expressions ||= []
      @expressions << expression
    end

    def self.run(command)
      result = nil
      found = false
      @expressions.each do |expression|
        cucumber, block = expression
        expression_text = cucumber.instance_variable_get("@expression")
        matched = cucumber.match(command)

        next if matched.nil?

        puts Rainbow("=" * 20).yellow
        puts Rainbow("Hey running.... #{expression_text}").yellow
        puts Rainbow("=" * 20).yellow

        block.call(*matched.map { |m| m.value(nil)})
        found = true
        break
      end
      raise "command not found in config file" unless found
      result
    end

    def self.expressions
      @expressions
    end

    def self.expressions_commands
      expressions.map{|e| e[0].instance_variable_get("@expression") }
    end
  end
end
