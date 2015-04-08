class Event < ActiveRecord::Base

  validates_presence_of :name

  belongs_to :category

  has_many :attendees, :dependent => :destroy

  has_many :event_groupships, :dependent => :destroy

  has_many :groups, :through => :event_groupships

  has_one :detail, :class_name => "EventDetail", :dependent => :destroy

end
