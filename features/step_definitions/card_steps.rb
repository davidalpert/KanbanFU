Given /^I have the cards for project "([^"]*)":$/ do |project_id, table|
  project = Project.create!(id: project_id, name: "Blazing Saddles", description: "Good movie")
  table.hashes.each do |attr| 
    project.cards.create!(attr)
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
