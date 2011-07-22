Given /^I have the projects:$/ do |table|
  projects = table.hashes.collect { |attributes| Project.create!(attributes) }
end



