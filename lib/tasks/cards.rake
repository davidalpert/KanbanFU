
namespace :cards do

  desc 'Roles'
  task :roles => :environment do
    prj = Project.find(1)
    backlog = Phase.find(1)
    prj.cards.create!(size: 2, 
                      phase: backlog, 
                      title: 'CRUD Roles', 
                      description: <<eos)
    As an admin
    I want to manage roles
    So I can assign different access to users
eos
  end

  desc 'Bug'
  task :bug => :environment do
    prj = Project.find(1)
    backlog = Phase.find(1)
    prj.cards.create!(size: 2, 
                      phase: backlog, 
                      title: 'BUG: Reset password resets all users', 
                      description: <<eos)
    As an admin
    I want to reset the password for one user
    So I don't change others user's passwords
eos
  end

  desc 'VP change password'
  task :vp => :environment do
    prj = Project.find(1)
    backlog = Phase.find(1)
    prj.cards.create!(size: 2, 
                      phase: backlog, 
                      title: 'VP Reset Password', 
                      description: <<eos)
    As an admin
    I want to reset the password
    So I can forget it and get it again
eos
  end

  
  desc 'Change card size'
  task :size, [:title, :size] => :environment do |t, args|
    c = Card.find_by_title(args.title)
    c.update_attributes(size: args.size) 
    puts "The card has been updated to size #{c.size} on phase #{c.phase.name}"
  end
  
end

