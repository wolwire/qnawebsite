namespace :app do
  desc 'Manage application task'

  task :deploy do
    on roles(:all) do
      within current_path do
        execute :bundle, :exec, :rake, 'deploy', "RAILS_ENV=#{fetch(:stage)}"
      end
    end
  end
  after 'deploy:finished', 'app:deploy'
end
