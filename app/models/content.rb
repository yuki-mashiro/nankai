class Content
  include Mongoid::Document
  include Mongoid::Timestamps

  store_in collection: 'content'
  field :_id, type: Integer
  field :name, type: String
  field :status, type: Integer
  field :latency_time, type: Integer
  field :check_latency_time, type: Time
  field :image, type: String
  field :event_id, type: Integer
  field :user_id, type: String
  field :updated_at, type: Time
  field :created_at, type: Time
  field :hour, type: Integer
  field :minute, type: Integer

  def self.status
    { 0 => '通常', 1 => '一時休止中', 2 => '休止', 3 => '準備中' }
  end

  def self.name_list
    [['工場見学', 0], ['ラピート車内見学会', 1], ['天空サイクル' , 2], ['子ども車掌体験', 3], ['南海・真田赤備え列車の展示', 4]]
  end

  def hour
    self.check_latency_time.hour
  end

  def minute
    self.check_latency_time.min
  end
end
