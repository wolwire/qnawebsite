# Load configuration for capistrano
CAP_CONFIG = YAML.load_file(File.expand_path('../config/capistrano.local.yml', __FILE__))

# Load DSL and set up stages
require 'capistrano/setup'

# Include default deployment tasks
require 'capistrano/deploy'
require 'capistrano/rvm'
require 'capistrano/bundler'
require 'capistrano/rails'
require 'capistrano/rails/migrations'
# require 'capistrano/rails/assets'

require 'capistrano/bundle_rsync/plugin'
install_plugin Capistrano::BundleRsync::Plugin

require_relative 'lib/capistrano/recipies/base'
require_relative 'lib/capistrano/recipies/config'
require_relative 'lib/capistrano/recipies/puma'
