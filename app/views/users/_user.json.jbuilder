json.extract! user, :id, :login_id, :password, :name, :is_admin, :last_updated_at, :created_at, :updated_at
json.url user_url(user, format: :json)