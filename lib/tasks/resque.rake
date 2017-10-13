require 'resque/tasks'

namespace :resque do
  desc "Setup resque"
  task setup: :environment do
    require 'resque'
  end

end
