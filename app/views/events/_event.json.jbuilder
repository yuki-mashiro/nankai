json.extract! event, :id, :lang, :name, :status, :user_id, :created_at, :updated_at
json.url event_url(event, format: :json)