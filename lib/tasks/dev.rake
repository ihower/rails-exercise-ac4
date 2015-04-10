namespace :dev do

  task :fake => :environment do
    puts "Fake!!"

    User.delete_all
    Event.delete_all

    User.create( :email => "ihower@gmail.com", :password => "12345678")

    100.times do |i|
      puts "Faking #{i}~~~~~ "
      user = User.create( :email => Faker::Internet.email, :password => "12345678")

      group_id1 = rand( Group.count ) + 1
      group_id2 = rand( Group.count ) + 1
      group_ids = [group_id1, group_id2].uniq

      Event.create( :name => Faker::Name.name , :user => user, :description => Faker::Lorem.sentence, :published_at => Faker::Date.between(2.days.ago, Date.today), :group_ids => group_ids )
    end

  end

end