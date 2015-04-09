class Event < ActiveRecord::Base

  validates_presence_of :name

  belongs_to :user
  belongs_to :category

  has_many :attendees, :dependent => :destroy

  has_many :event_groupships, :dependent => :destroy

  has_many :groups, :through => :event_groupships

  has_one :detail, :class_name => "EventDetail", :dependent => :destroy

  accepts_nested_attributes_for :detail, :allow_destroy => true, :reject_if => :all_blank

  def author_name
    if user
      user.display_name
    else
      "Nobody"
    end
  end

end
