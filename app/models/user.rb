class User
  include Mongoid::Document
  include Mongoid::Timestamps

  store_in collection: 'user'
  field :_id, type: Integer
  field :login_id, type: String
  field :password, type: String
  field :name, type: String
  field :is_admin, type: Integer
  field :last_updated_at, type: Time
end
