# Use this file to easily define all of your cron jobs.
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

#  gemのwheneverによるスクリプト。詳細は下記を確認
# https://github.com/javan/whenever

require File.expand_path("#{File.dirname(__FILE__)}/environment")
rails_env = ENV.fetch('RAILS_ENV', :production)
set :environment, rails_env
is_developement = rails_env.to_sym === :development

# 本番はアプリログと同一にする
logfile_name = "#{Rails.root}/log/production.log"
logfile_name = "#{Rails.root}/log/cron-#{Date.today.strftime('%Y-%m-%d')}.log" if is_developement
set :output, logfile_name

# dockerの場合、cron実行時にenv値が反映されないため、追加
if is_developement
  ENV.each { |k, v| env(k, v) }
end

every :day, at: '07:00am' do
  rake 'reservation:send_remind_mail'
end
