json.array!(@giveaways) do |giveaway|
  json.extract! giveaway, :id
  json.url giveaway_url(giveaway, format: :json)
end
