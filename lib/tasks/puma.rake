PUMA_CONFIG = "#{Dir.pwd}/../../config/puma.rb"
PUMA_PID_FILE = "#{Dir.pwd}/../../tmp/pids/puma.pid"
PUMA_SOCK_FILE = "#{Dir.pwd}/../../tmp/sockets/puma.sock"

namespace :puma do
  desc 'Manage Puma'

  def get_puma_pid
    command = "ps auxwe | grep puma | grep tcp | grep -v 'cluster worker' | grep #{Rails.application.class.parent_name} | awk '{print $2}'"
    exec(command)
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
    unless puma_running?
      execute :rm, fetch(:puma_pid_file) if test("[ -f #{PUMA_PID_FILE} ]")
      execute :bundle, :exec, :puma, '--config config/puma.rb'
    end
  end
end
