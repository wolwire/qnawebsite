# # config valid for current version and patch releases of Capistrano
# role :app, "mayankagrawal.in"
#
# set :application, "stack_over_flow"
# # set :repo_url, "https://github.com/wolwire/stack_over_flow.git"
# set :stages, ["staging", "production"]
# set :default_stage, "staging"
# set :bundle_rsync_scm, :local_git
# set :repo_url, fetch(:local_path)
# set :deploy_to, "~/#{fetch(:application)}"
# set :local_path, "~/"
# set :assets_roles, [:app]
#
# append :linked_dirs, 'log', 'tmp/pids', 'tmp/sockets', 'vendor/bundle', 'bundle', 'public'
# append :linked_files, 'config/config.json'

# set :bundle_rsync_rsync_options, '-az --delete --exclude=.local_repo'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml"

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure

## define roles
CAP_CONFIG['roles'].each do |role, ips|
  role role, ips
end
set :rvm_ruby, "2.7.0"
set :application, CAP_CONFIG['app_name']
set :branch, (CAP_CONFIG['branch'] || 'master ')
set :user, :pi
# set :deploy_user, :ubuntu
set :use_sudo, true
set :deploy_to, "#{CAP_CONFIG['paths']['server']}/#{fetch(:application)}"
set :local_path, "#{CAP_CONFIG['paths']['local']}"
set :bundle_path, -> { shared_path.join('bundle') }
set :ssh_options, { user: fetch(:user) }
set :bundle_rsync_scm, :local_git
set :repo_url, fetch(:local_path)
set :old_release, ENV['old_release']
set :bundle_rsync_rsync_options, '-az --delete --exclude=.local_repo'
set :assets_roles, [:app]
set :default_env, CAP_CONFIG['default_env']
set :user, :mayank
set :deploy_user, :mayank
set :keep_releases, 1

append :linked_files, 'config/config.json'
append :linked_dirs, 'log', 'tmp/pids', 'tmp/sockets', 'vendor/bundle', '.bundle', 'public'
