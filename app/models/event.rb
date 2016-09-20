class Event
  include Mongoid::Document
  include Mongoid::Timestamps
  field :_id, type: Integer
  field :lang, type: String
  field :name, type: String
  field :status, type: Integer
  field :user_id, type: Integer
end
