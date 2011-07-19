Given /^I have the projects:$/ do |table|
  projects = table.hashes.collect { |project| Project.create project }
end



