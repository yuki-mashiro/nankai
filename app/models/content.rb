class Content
  include ActiveModel::Model
  include Mongoid::Document
  include Mongoid::Timestamps

  validates_presence_of :id, :state, :hour, :minute
  validates_presence_of :latency_time, if: 'state == 0'

  store_in collection: 'content'
  field :_id, type: Integer
  field :name_ja, type: String
  field :name_en, type: String
  field :state, type: Integer
  field :latency_time, type: Integer
  field :check_latency_time, type: Time
  field :image, type: String
  field :event_id, type: Integer
  field :user_id, type: Integer
  field :updated_at, type: Time
  field :created_at, type: Time
  field :hour, type: Integer
  field :minute, type: Integer

  def self.state_list
    [['通常', 0], ['一時休止中', 1], ['休止', 2], ['準備中', 3]]
  end

  def self.name_list
    Content.all.map { |content| [content.name_ja, content._id] }
  end

  def hour
    self.check_latency_time.present? ? self.check_latency_time.hour : nil
  end

  def minute
    self.check_latency_time.present? ? self.check_latency_time.min : nil
  end
end
