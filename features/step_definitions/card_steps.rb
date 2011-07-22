Given /^I have the cards for project "([^"]*)":$/ do |project_id, table|
  project = Project.create!(id: project_id, name: "Blazing Saddles", description: "Good movie")
  table.hashes.each do |attr| 
    project.cards.create(attr)
  end
end

