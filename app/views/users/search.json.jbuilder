json.array!(@users) do |user|
  json.trello_id    user.trello_id
  json.github_id    user.github_id
end
