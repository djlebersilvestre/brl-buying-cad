namespace :unicorn do
  desc 'Start unicorn using config/unicorn.rb'
  task :start do
    sh 'dotenv unicorn -c config/unicorn.rb'
  end

  desc 'Graceful stop on unicorn PID'
  task :stop do
    Rake::Task['unicorn:pid'].invoke
    sh "kill -QUIT #{@pid}" unless @pid.empty?
  end

  desc 'Force stop on unicorn PID'
  task :force_stop do
    Rake::Task['unicorn:pid'].invoke
    sh "kill #{@pid}" unless @pid.empty?
  end

  desc 'Graceful restart on unicorn PID (has no downtime)'
  task :reload do
    Rake::Task['unicorn:pid'].invoke
    unless @pid.empty?
      n_masters = ps_n_masters
      sh "kill -USR2 #{@pid}"
      sleep(2) while ps_n_masters < n_masters + 1
      sh "kill -QUIT #{@pid}"
    end
  end

  desc 'Restart on unicorn PID'
  task :restart do
    Rake::Task['unicorn:stop'].invoke
    Rake::Task['unicorn:start'].invoke
  end

  desc 'Show unicorn PID'
  task :pid do
    `touch #{ENV.fetch('BRLCAD_UNICORN_PID')}`
    @pid = `cat #{ENV.fetch('BRLCAD_UNICORN_PID')}`
    puts "Unicorn PID: #{@pid}"
  end
end

def ps_n_masters
  `ps aux | grep 'unicorn master' | grep -v grep | wc -l`.to_i
end
