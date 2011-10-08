
namespace :cards do
  
  desc 'Clears all the stories'
  task :clear => :environment do
    Card.destroy_all
  end
  
  desc 'Creates a new card'
  task :create, [:project, :title, :description] => :environment do |t, args|
    p = Project.find_by_name(args.project)
    c = p.cards.create(title: args.title, 
                       description: args.description, 
                       phase: Phase.find_by_name('Backlog'))
    puts "Card created: #{c.title} in phase #{c.phase.name}"
  end
  
  desc 'Change card size'
  task :size, [:title, :size] => :environment do |t, args|
    c = Card.find_by_title(args.title)
    c.update_attributes(size: args.size) 
    puts "The card has been updated to size #{c.size} on phase #{c.phase.name}"
  end
  
  desc 'Mark a card as finished'
  task :archive, [:title, :started, :finished] => :environment do |t, args|
    c = Card.find_by_title(args.title)
    c.update_attributes(started_on: args.started, 
                        finished_on: args.finished,
                        phase: Phase.find_by_name('Archive'))
                        
    puts "The card has been updated to #{c.started_on} and #{c.finished_on} on phase #{c.phase.name}"
  end
  
end

namespace :projects do 
  
  desc 'Clears all projects'
  task :clear => :environment do
    Project.delete_all
  end
  
  desc 'Create phases' 
  task :phases => :environment do
    Phase.delete_all
    %w(Archive Backlog Analysis Working Review).each { |w| Phase.create(name: w) }
    Phase.all.each { |p| puts "* Phase #{p.name}"}
  end
  
  desc 'Create a project'
  task :create, [:name, :description] => :environment do |t, args|
    p = Project.create(name: args.name, description: args.description)
    puts "Created project #{p.name} with id #{p.id} and description #{p.description}"
  end

  desc 'List cards of a project'
  task :cards, [:name] => :environment do |t, args|
    p = Project.find_by_name(args.name)
    puts "Can't find project by name '#{args.name}'" unless p
    puts "Cards for project '#{args.name}'"
    p.cards.each { |c| puts "Card #{c.id}, '#{c.title}' in phase #{c.phase.name}, #{c.started_on}, #{c.finished_on}" }
  end
end