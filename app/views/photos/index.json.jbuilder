json.array!(@photos) do |photo|
  json.extract! photo, :id, :event_id, :program_id, :brand_id, :image_url, :tag_list
  json.url photo_url(photo, format: :json)
end
