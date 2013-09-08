$stdout.sync = true

namespace :scrapper do
  desc 'Check for the latest strip'
  task :latest => :environment do
    Scrapper.new.latest
  end

  desc 'Check all strips'
  task :all => :environment do
    Scrapper.new.all
  end
end
