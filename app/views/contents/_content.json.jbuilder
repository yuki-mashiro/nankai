json.extract! content, :id, :name, :status, :latency_time, :check_latency_time, :image, :event_id, :created_at, :updated_at
json.url content_url(content, format: :json)