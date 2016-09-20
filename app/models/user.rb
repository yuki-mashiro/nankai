class User
  include Mongoid::Document
  include Mongoid::Timestamps
  field :_id, type: Integer
  field :login_id, type: String
  field :password, type: String
  field :name, type: String
  field :is_admin, type: Integer
  field :last_updated_at, type: Time
end
