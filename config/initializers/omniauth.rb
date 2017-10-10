Rails.application.config.middleware.use OmniAuth::Builder do
  provider :trello, Rails.application.secrets['trello_key'], Rails.application.secrets['trello_secret'],
  app_name: "pitch-day-planner", scope: 'read,write,account', expiration: 'never'

  provider :github, Rails.application.secrets['github_id'],
    Rails.application.secrets['github_secret'], scope: "user:email:repo"

end
