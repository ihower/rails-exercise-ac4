class Event < ActiveRecord::Base

  validates_presence_of :name

  belongs_to :category

  has_many :attendees, :dependent => :destroy

end
