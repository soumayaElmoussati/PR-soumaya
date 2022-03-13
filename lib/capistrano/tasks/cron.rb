namespace :cron do
  desc 'Refresh the crontab'
  task :update do
    on roles(:back) do
      within release_path do
        execute 'docker-compose', "-f #{fetch :docker_file}", :run, '-T', :db, :bash, '-c "whenever', '--update-crontab --load-file /root/schedule.rb"'
        execute 'docker-compose', "-f #{fetch :docker_file}", :run, '-T', :back, :bash, '-c "whenever', '--update-crontab"'
      end
    end
  end
end
