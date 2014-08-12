json.array!(@branches) do |branch|
  json.extract! branch, :id, :nazwa
  json.url branch_url(branch, format: :json)
end
