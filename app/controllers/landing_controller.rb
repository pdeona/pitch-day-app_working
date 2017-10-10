class LandingController < ApplicationController

  before_action :current_user

  def index
    # redirect_to login_path if current_user.nil?
  end

  def graph
    @client = Octokit::Client.new(access_token: @current_user.github_oauth)
    languages = @client.languages('pdeona/capleo-f-f')
    language_obj = (languages.to_hash)
    langs = []
    language_obj.each do |lang, count|
      langs.push :language => lang, :count => count
    end
    @langs = langs.to_json
    respond_to do |f|
      f.js { render partial: 'layouts/graph', langs: @langs }
      f.json { render partial: 'layouts/graph' }
    end
  end

end
