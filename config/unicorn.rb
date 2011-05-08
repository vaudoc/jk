# config/unicorn.rb
#
# Configuration file for Unicorn for Sinatra in production
#
# @example
#   Make sure nginx server is running and start unicorn via
#     $ unicorn -c config/unicorn.rb -E production -D
#
# @see
#   http://unicorn.bogomips.org/examples/unicorn.conf.rb
#

# Current application
deploy_to = '/var/www/apps/jankuhl'
current_app_path = "#{deploy_to}/current"

# Use at least one worker per core
worker_processes 1

# Help ensure your application will always spawn in the symlinked
# "current" directory that Capistrano sets up.
working_directory current_app_path

# Listen to TCP socket proxied by nginx.
# We use a shorter backlog for quicker failover when busy.
listen '127.0.0.1:2178', :backlog => 64

# Nuke workers after 30 seconds instead of 60 seconds (the default)
timeout 30

# Point this anywhere accessible on the filesystem
pid "#{deploy_to}/shared/pids/unicorn.pid"

# By default, the Unicorn logger will write to stderr.  Additionally,
# ome applications/frameworks log to stderr or stdout, so prevent them
# from going to /dev/null when daemonized here:
stderr_path "#{current_app_path}/log/unicorn.stderr.log"
stdout_path "#{current_app_path}/log/unicorn.stdout.log"

before_fork do |server, worker|
  # Place all your 'stable' code here, for example rubygems, the ruby
  # stdlib maybe even parts of your application. Since it's preloaded,
  # it doesn't need to be reloaded when unicorn receives a HUP.
end

after_fork do |server, worker|
  # Here you can load up things which need to run in each process
end
