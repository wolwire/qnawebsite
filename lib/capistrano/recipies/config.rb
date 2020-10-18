set_default(:config_name, 'config.json')
set_default(:config_path, CAP_CONFIG['paths']['config'])

namespace :config do
  desc 'Setup configuration'
  task :upload do |t|
    run_locally do
      on roles(:all) do
        upload!("#{fetch(:config_path)}/#{fetch(:config_name)}" , "#{shared_path}/config")
      end
    end
  end

  desc 'Setup Release Path'
  task :setup_release_path do
    run_locally do
      latest_release_version = capture(:cat, "#{fetch(:local_path)}/tmp/last_release_timestamp.txt") rescue nil
      if fetch(:old_release) && !latest_release_version.to_s.empty?
        set(:release_timestamp, latest_release_version)
        set(:release_path, releases_path.join(latest_release_version))
      else
        execute :mkdir, '-p', "#{fetch(:local_path)}/tmp"
        execute :echo, "#{fetch(:release_timestamp)} > #{fetch(:local_path)}/tmp/last_release_timestamp.txt"
      end
    end
  end

  before 'deploy:check:linked_files', 'config:upload'
  before 'bundle_rsync:rsync_release', 'config:setup_release_path'
end
