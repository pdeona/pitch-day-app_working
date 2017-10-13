class LandingController < ApplicationController
  before_action :current_user, only: :graph
  def index

  end

  def graph
    @repo_name = 'cc_platform_working'
    @client = Octokit::Client.new(access_token: @current_user.github_oauth)
    languages = @client.languages("#{@current_user.github_id}/#{@repo_name}")
    language_obj = (languages.to_hash)
    langs = []
    language_obj.each do |lang, count|
      langs.push :language => lang, :count => count
    end
    @langs = langs.to_json
    respond_to do |f|
      f.js { render partial: 'layouts/graph', langs: @langs }
    end
  end

end
