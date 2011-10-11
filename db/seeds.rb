# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# phases
[:backlog, :analysis, :working, :review, :archive].each_with_index do |p, i|
  Phase.create!(name: p.to_s.capitalize, show_order: i, description: "The phase #{p.to_s}") 
end

backlog = Phase.find_by_name('Backlog')
  
prj = Project.create!(name: 'Peer review', description: 'Review your peers and help the team')

prj.cards.create!(size: 2, phase: backlog, title: 'Log in', description: <<eos)
As a user
I want to login to the application
So I can review my peers
eos

prj.cards.create!(size: 1, phase: backlog, title: 'Pending reviews', description: <<eos)
As a user
I want to see the list of my pending reviews
So that I know which ones I need to work on
eos

prj.cards.create!(size: 2, phase: backlog, title: 'Answer Questions', description: <<eos)
As a user
I want to answer the review questions
So I can complete the review for a peer
eos

prj.cards.create!(size: 3, phase: backlog, title: 'Manage Users', description: <<eos)
As an admin
I want to create and manage users
So multiple people can access the application
eos

prj.cards.create!(size: 3, phase: backlog, title: 'CRUD Reviews', description: <<eos)
As a manager
I want to crud reviews
So they can be filled out by the employees
eos

prj.cards.create!(size: 3, phase: backlog, title: 'CRUD Questions', description: <<eos)
As a manager
I want to crud review questions
So they can be answered by the employees
eos

prj.cards.create!(size: 1, phase: backlog, title: 'List completed reviews', description: <<eos)
As a manager
I want to see who has completed their reviews
So I can remind the missing to do so
eos

prj.cards.create!(size: 1, phase: backlog, title: 'Notifications', description: <<eos)
As a Manager
I want to get notified when a review is complete
So I can look at the results
eos

prj.cards.create!(size: 2, phase: backlog, title: 'Results Reviews', description: <<eos)
As a Manager
I want to see the results of the reviews
So I can decide how to improve the team
eos




