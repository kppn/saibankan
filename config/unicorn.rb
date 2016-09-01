# -*- coding: utf-8 -*-
# ワーカーの数
worker_processes 2

# ソケット
listen '/home/popaadmin/projects/saibankan/tmp/sockets/unicorn.sock'

# PID
listen '/home/popaadmin/projects/saibankan/tmp/pids/unicorn.pid'


# ログ
log = '${my_app}/log/unicorn.log'
stdout_path File.expand_path('log/unicorn_stdout.log', '/home/popaadmin/projects/saibankan/')
stderr_path File.expand_path('log/unicorn_stderr.log', '/home/popaadmin/projects/saibankan/')

preload_app true
GC.respond_to?(:copy_on_write_friendly=) and GC.copy_on_write_friendly = true

before_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.connection.disconnect!

  old_pid = "#{ server.config[:pid] }.oldbin"
  unless old_pid == server.pid
    begin
     sig = (worker.nr + 1) >= server.worker_processes ? :QUIT : :TTOU
     Process.kill :QUIT, File.read(old_pid).to_i
     rescue Errno::ENOENT, Errno::ESRCH
    end
  end
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
end
