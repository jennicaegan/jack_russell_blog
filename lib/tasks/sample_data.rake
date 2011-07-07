namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    make_users
    make_posts
    make_relationships
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
  User.all(:limit => 6).each do |user|
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

def make_conversations
  users = User.all(:limit => 25)
  user = users.first
  a_post = user.posts.first
  
  listening = users[1..24]
  speaking  = users[2..18]
  
  listening.each do |listener|
    listen_post = listener.posts.first
    title = Faker::Name.name
    content = Faker::Lorem.sentence(5)
    user_post = user.posts.create!(:title => title, :content => content)
    user_post.speak!(listen_post)
  end
  
  speaking.each do |speaker|
    title = Faker::Name.name
    content = Faker::Lorem.sentence(5)
    speak_post = speaker.posts.create!(:title => title, :content => content)
    speak_post.speak!(a_post)
  end
end