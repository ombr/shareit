worker_processes 3
timeout 30
preload_app true

@delayed_job_pid = nil

before_fork do |server, worker|

  Signal.trap 'TERM' do
    puts 'Unicorn master intercepting TERM and sending myself QUIT instead'
    Process.kill 'QUIT', Process.pid
  end


  if defined?(ActiveRecord::Base)
    @delayed_job_pid ||= spawn("bundle exec rake jobs:work")
  end
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!

end

after_fork do |server, worker|

  Signal.trap 'TERM' do
    puts 'Unicorn worker intercepting TERM and doing nothing. Wait for master to sent QUIT'
  end

  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
end
