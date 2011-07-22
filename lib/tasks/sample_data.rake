namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    make_users
    make_posts
    make_relationships
    make_comments
  end
end

def make_users
  admin = User.create!(  :name => "Yushi Hu",
                         :email => "yushihu@example.com",
                         :password => "meninhats",
                         :password_confirmation => "meninhats")
  admin.toggle!(:admin)
  99.times do |n|
    name  = Faker::Name.name
    email = "example-#{n+1}@railstutorial.org"
    password  = "password"
    User.create!(:name => name,
                 :email => email,
                 :password => password,
                 :password_confirmation => password)
  end
end

def make_posts
  User.all(:limit => 12).each do |user|
    10.times do
      title = Faker::Name.name
      content = Faker::Lorem.sentence(5)
      user.posts.create!(:title => title, :content => content)
    end
  end
end

def make_relationships
  users = User.all
  user  = users.first
  following = users[1..50]
  followers = users[3..40]
  following.each { |followed| user.follow!(followed) }
  followers.each { |follower| follower.follow!(user) }
end

def make_comments
  users = User.all(:limit => 25)
  user = users.first
  
  listeners = users[3..10]
  speakers  = users[1..10]
  
  listeners.each do |l|
    speakers.each do |s|
      listen_post = l.posts.first
      content = Faker::Lorem.sentence(5)
      comment = listen_post.comments.create!(:content => content)
      comment.user_id = s.id
    end
  end
end