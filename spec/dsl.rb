Hey("I have {int} cucumber(s) in my belly/stomach") do |value|
  @value_in_dsl = value
end

Hey("This is a ls command") do
  run "ls"
end
