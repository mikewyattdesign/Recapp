# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

brand_list = [
"Busch",
"Natural Light",
"Rolling Rock",
"Shock Top",
"Michelob",
"LandShark"
]

brand_list.each do | name |
    Brand.find_or_create_by(name: name)
end

giveaway_list = [
"Plastic Glasses",
"Wristbands",
"T-Shirts",
"One Sheets",
"Coozies",
"Blankets",
"Necklace Beads",
"Magnets",
"Stickers"
]

giveaway_list.each do | name |
    Giveaway.find_or_create_by(name: name)
end
