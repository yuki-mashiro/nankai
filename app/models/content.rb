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

  def self.state
    { 0 => '通常', 1 => '一時休止中', 2 => '休止', 3 => '準備中' }
  end

  def self.name_list
    [['工場見学', 0], ['ラピート車内見学会', 1], ['天空サイクル' , 2], ['子ども車掌体験', 3], ['南海・真田赤備え列車の展示', 4]]
  end

  def hour
    self.check_latency_time.present? ? self.check_latency_time.hour : nil
  end

  def minute
    self.check_latency_time.present? ? self.check_latency_time.min : nil
  end
end
