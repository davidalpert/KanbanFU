Given /^I have the projects:$/ do |table|
  table.hashes.each { |project| Project.create project }
end
