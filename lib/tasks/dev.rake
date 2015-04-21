namespace :dev do

  task :test_update_all => :environment do

    ids = Event.pluck(:id)
    puts ids.count

    Benchmark.bm do |x|
      x.report {
        # 86 * 2 queries
        ids.each do |i|
          event = Event.find(i)
          event.update( :capacity => 200 )
        end
      }
      x.report {
        # 86
        ids.each do |i|
          Event.where( :id => i ).update_all( :capacity => 200 )
        end
      }
      x.report {
        # 1
        Event.where( :id => ids ).update_all( :capacity => 200 )
      }
    end

  end

  task :fake => :environment do
    puts "Fake!!"

    User.delete_all
    Event.delete_all

    User.create( :email => "ihower@gmail.com", :password => "12345678", :role => "admin")

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