class Group < ActiveRecord::Base

  has_many :event_groupships, :dependent => :destroy

  has_many :events, :through => :event_groupships

end
