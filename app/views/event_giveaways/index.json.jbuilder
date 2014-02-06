json.array!(@event_giveaways) do |event_giveaway|
  json.extract! event_giveaway, :id
  json.url event_giveaway_url(event_giveaway, format: :json)
end
