require_relative 'boot'

require 'rails/all'
require 'faker'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Qnawebsite
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0
    Faker::Config.locale = :en

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    env_file = File.join(Rails.root, 'config', 'config.json')
    JSON.parse(File.read(env_file)).each do |key, value|
      ENV[key.to_s] = value
    end
  end
end
