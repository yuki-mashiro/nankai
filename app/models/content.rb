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
end
