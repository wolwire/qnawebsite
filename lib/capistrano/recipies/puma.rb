set_default :puma_config, -> { "#{release_path}/config/puma.rb" }
set_default :puma_pid_file, -> { "#{current_path}/tmp/pids/puma.pid" }
set_default :puma_sock_file, -> { "#{current_path}/tmp/sockets/puma.sock" }

namespace :puma do
  desc 'Manage Puma'

  def get_puma_pid
    command = "ps auxwe | grep puma | grep tcp | grep -v 'cluster worker' | grep #{fetch(:deploy_to)} | awk '{print $2}'"
    capture(command) if test(command)
  end

  def puma_running?
    not get_puma_pid.to_s.empty?
  end

  task :status do
    on roles(:app) do
      within current_path do
        if puma_running?
          puts 'Puma is running'
        else
          puts 'Puma is not running'
        end
      end
    end
  end

  task :start do
    on roles(:app) do
      within current_path do
        execute :rm, fetch(:puma_pid_file) if test("[ -f #{fetch(:puma_pid_file)} ]")
        if puma_running?
          invoke('puma:restart')
        else
          execute :bundle, :exec, :puma, '--config config/puma.rb'
        end
      end
    end
  end

  task :stop do
    on roles(:app) do
      within current_path do
        pid = get_puma_pid
        execute :kill, '-s', 'SIGTERM', pid if pid

        execute :rm, fetch(:puma_pid_file) if test("[ -f #{fetch(:puma_pid_file)} ]")
        execute :rm, fetch(:puma_sock_file) if test("[ -f #{fetch(:puma_sock_file)} ]")
      end
    end
  end

  task :restart do
    on roles(:app) do
      within current_path do
        if puma_running?
          puts 'Hot Rebooting Puma'
          pid = get_puma_pid
          execute :kill, '-s', 'SIGUSR2', pid

          sleep(5)
          if puma_running?
            # Restart successfull
            break
          end

          puts 'Hot Rebooting Failed'
        end

        puts 'Cold Rebooting Puma'
        invoke('puma:stop')
        invoke('puma:start')
      end
    end
  end
  after 'deploy:log_revision', 'puma:restart'

  task :setup do
    on roles(:app) do
      template 'puma.rb.erb', fetch(:puma_config)
    end
  end
  %i[start restart].each do |task|
    before "puma:#{task}", 'puma:setup'
  end
end
