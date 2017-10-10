Octokit.configure do |config|
  config.client_id = Rails.application.secrets['github_id']
  config.client_secret = Rails.application.secrets['github_secret']
end
