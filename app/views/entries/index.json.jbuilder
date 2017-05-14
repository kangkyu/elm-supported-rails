json.array! @entries do |entry|
  json.extract! entry, :id, :phrase, :points
end
