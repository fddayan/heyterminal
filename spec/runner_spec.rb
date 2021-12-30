RSpec.describe Heyterminal::Runner do
  let(:parser) { Heyterminal::Runner.load(File.join(__dir__, './dsl.rb')) }

  before do
    parser
  end

  # it "should run command with arguments" do
  #   expect(Heyterminal::Runner.expressions).not_to be_empty
  #
  #   Heyterminal::Runner.run("I have 3 cucumbers in my belly")
  #
  #   expect(parser.instance_variable_get("@value_in_dsl")).to eq(3)
  # end

  it "should run command with terminal execution" do
    expect(Heyterminal::Runner.expressions).not_to be_empty

    # puts "#{Heyterminal::Runner.expressions}"

    Heyterminal::Runner.run("This is a ls command")
  end
end
