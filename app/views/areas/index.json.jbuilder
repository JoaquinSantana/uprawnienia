json.array!(@areas) do |area|
  json.extract! area, :id, :nazwa
  json.url area_url(area, format: :json)
end
