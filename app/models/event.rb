class Event < ActiveRecord::Base

  attr_accessor :_destory_logo

  STATUS = ["published", "draft"]

  validates_presence_of :name, :friendly_id

  validates_uniqueness_of :friendly_id

  belongs_to :user
  belongs_to :category

  has_many :attendees, :dependent => :destroy

  has_many :event_groupships, :dependent => :destroy

  has_many :groups, :through => :event_groupships

  has_one :detail, :class_name => "EventDetail", :dependent => :destroy

  accepts_nested_attributes_for :detail, :allow_destroy => true, :reject_if => :all_blank

  has_attached_file :logo, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :logo, :content_type => /\Aimage\/.*\Z/

  before_validation :setup_friendly_id

  before_validation :remove_logo

  has_many :taggings
  has_many :tags, :through => :taggings

  def to_param
    self.friendly_id
  end

  def tag_list
    self.tags.map{ |t| t.name }.join(",")
  end

  def tag_list=(value)
    tags = value.split(",").map { |tag_name|
      tag_name = tag_name.strip
      Tag.find_by_name(tag_name) || Tag.create( :name => tag_name)
    }

    self.tag_ids = tags.map{ |x| x.id }
  end

  def author_name
    if user
      user.display_name
    else
      I18n.t("nobody")
    end
  end

  def remove_logo
    if self._destory_logo
      self.logo = nil
    end
  end

  def setup_friendly_id
    self.friendly_id ||= SecureRandom.hex(8)
  end

end
