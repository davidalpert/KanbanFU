Then /^the response should be a collection of "(.+)" with:$/ do |root, table|
  table.hashes.each do |row|
    add = if_exists(row, 'started_on') { |s| DateTime.parse(s).strftime('%Y-%m-%dT00:00:00Z') }.
          merge(if_exists(row, 'finished_on') { |s| DateTime.parse(s).strftime('%Y-%m-%dT00:00:00Z') }).
          merge(if_exists(row, 'size') { |s| s.to_i }).
          merge(if_exists(row, 'waiting_time') { |s| s.to_f }).
          merge(if_exists(row, 'blocked_time') { |s| s.to_f })
          
    json = row.merge(add).to_json
    path = "#{root}/#{row['id'].to_i - 1}"
    Then(%Q{the JSON at "#{path}" should be #{json}})
  end
end

Then /^the response should be a "([^"]+)" with:$/ do |root, table|
  row = table.hashes.first
  Then(%Q{the JSON at "#{root}" should be #{row.to_json}})
end

Then /^the response should be "([^"]*)"$/ do |status|
  page.driver.status_code.should == status.to_i
end
