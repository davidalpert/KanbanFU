Given /^I have the cards for project "([^"]*)":$/ do |project_id, table|
  project = Project.create!(id: project_id, name: "Blazing Saddles", description: "Good movie")
  table.hashes.each do |row| 
    phase = Phase.find_or_create_by_name(row.delete('phase'))
    add = if_exists(row, 'size') { |s| s.to_i }.
          merge(parse_if_exists(row, 'finished_on', DateTime)).
          merge(parse_if_exists(row, 'started_on', DateTime)).
          merge('phase' => phase)
    card = project.cards.create!(row.merge(add))
  end
end

Given /^I post to "\/cards" for project "([^"]*)" with:$/ do |project_id, table|
  project = Project.create!(id: project_id, name: "Blazing Saddles", description: "Good movie")
  post_resource "/projects/#{project_id}/cards", 'card', table.hashes
end

When /^I put to "\/cards" for project "([^"]*)" and card "([^"]*)" with:$/ do |project_id, card_id, table|
  project = Project.create!(id: project_id, name: "Blazing Saddles", description: "Good movie")
  put_resource "/projects/#{project_id}/cards/#{card_id}", 'card', table.hashes
end

When /^I delete card "([^"]*)" for project "([^"]*)"$/ do |card_id, project_id|
  project = Project.create!(id: project_id, name: "Blazing Saddles", description: "Good movie")
  delete_resource "/projects/#{project_id}/cards/#{card_id}"
end

When /^I put API "([^"]*)"$/ do |url|
  put url, format: :json
end

Then /^the card in response should be blocked$/ do
  Then(%Q{the JSON at "card/blocked" should be true})
end

Then /^the card in response should be ready$/ do
  Then(%Q{the JSON at "card/waiting" should be true})
end