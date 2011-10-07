Given /^I have the cards for project "([^"]*)":$/ do |project_id, table|
  project = Project.create!(id: project_id, name: "Blazing Saddles", description: "Good movie")
  table.hashes.each do |attr| 
    add = {phase: Phase.find_or_create_by_name(attr.delete(:phase))}.
          merge(if_exists(attr, 'size') { |s| s.to_i }).
          merge(parse_if_exists(attr, 'finished_on', DateTime)).
          merge(parse_if_exists(attr, 'started_on', DateTime))
    project.cards.create!(attr.merge(add))
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
