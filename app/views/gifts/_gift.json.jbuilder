json.extract! gift, :id, :gift_name, :giver_name, :taker_name, :gift_url, :image_url, :message, :slug, :created_at, :updated_at
json.url gift_url(gift, format: :json)
