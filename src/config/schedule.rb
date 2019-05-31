# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

rails_env = ENV.fetch('RAILS_ENV', :development)
set :environment, rails_env
is_developement = rails_env.to_sym === :development

require File.expand_path(File.dirname(__FILE__) + "/environment")
logfile_name = "#{Rails.root}/log/cron.log"
#logfile_name = "#{Rails.root}/log/cron/#{Date.today.strftime('%Y-%m-%d')}.log" if is_developement
set :output, logfile_name

# dockerの場合、cron実行時にenv値が反映されないため、追加
if is_developement
  ENV.each { |k, v| env(k, v) }
end

every :day, at: '07:00am' do
  rake 'reservation:send_remind_mail'
end
