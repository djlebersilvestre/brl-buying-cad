app_dir = File.expand_path '..', File.dirname(__FILE__)

working_directory app_dir

worker_processes ENV.fetch('BRLCAD_UNICORN_WORKERS').to_i

pid File.join(app_dir, ENV.fetch('BRLCAD_UNICORN_PID'))

listen(ENV.fetch('BRLCAD_UNICORN_LISTEN'))

preload_app true
GC.respond_to?(:copy_on_write_friendly=) && GC.copy_on_write_friendly = true

check_client_connection false

stdout_path File.join(app_dir, ENV.fetch('BRLCAD_UNICORN_STDOUT'))
stderr_path File.join(app_dir, ENV.fetch('BRLCAD_UNICORN_STDERR'))

before_fork do |_, _|
  defined?(ActiveRecord::Base) && ActiveRecord::Base.connection.disconnect!
end

after_fork do |_, _|
  defined?(ActiveRecord::Base) && ActiveRecord::Base.establish_connection
end
