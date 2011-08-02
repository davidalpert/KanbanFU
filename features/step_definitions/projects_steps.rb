Given /^I have the projects:$/ do |table|
  projects = table.hashes.collect { |attributes| Project.create!(attributes) }
end

Given /^I post to "\/projects" with:$/ do |table|
  post_resource('/projects', 'project', table.hashes)
end
