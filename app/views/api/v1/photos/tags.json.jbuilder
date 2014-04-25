json.array!(@photos) do |photo|
    json.extract! photo, :id, :tag_list
    json.url do
        json.original photo.image.url
        json.large photo.image.url(:large)
        json.medium photo.image.url(:medium)
        json.small photo.image.url(:small)
    end
end
