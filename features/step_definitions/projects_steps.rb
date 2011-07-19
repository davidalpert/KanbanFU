Given /^I have the projects:$/ do |table|
  projects = table.hashes.collect { |project| Project.create project }
end

Then /^the response should be a collection of "(.+)" with:$/ do |root, table|
  table.hashes.each do |row|
    json = row.to_s.gsub("=>", ":")
    path = "#{root}/#{row['id'].to_i - 1}"
    Then(%Q{the JSON at "#{path}" should be #{json}})
  end
end

