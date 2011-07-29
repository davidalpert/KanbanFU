Then /^the response should be a collection of "(.+)" with:$/ do |root, table|
  table.hashes.each do |row|
    json = row.to_json
    path = "#{root}/#{row['id'].to_i - 1}"
    Then(%Q{the JSON at "#{path}" should be #{json}})
  end
end

Then /^the response should be a "([^"]+)" with:$/ do |root, table|
  row = table.hashes.first
  Then(%Q{the JSON at "#{root}" should be #{row.to_json}})
end

Given /^I post to "([^"]*)" with:$/ do |resources, table|
  klass = resources.classify.downcase
  table.hashes.each do |attributes|
    post resources, :format => :json, :project => attributes  
  end
end
