class Content
  include Mongoid::Document
  include Mongoid::Timestamps
  field :_id, type: Integer
  field :name, type: String
  field :status, type: Integer
  field :latency_time, type: Integer
  field :check_latency_time, type: Integer
  field :image, type: String
  field :event_id, type: Integer
  field :user_id, type: String
  field :hour, type: Integer
  field :minute, type: Integer

  def self.status
    { 0 => "通常", 1 => "一時休止中", 2 => "休止", 3 => "準備中" }
  end
end
