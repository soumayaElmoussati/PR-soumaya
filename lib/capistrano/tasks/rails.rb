namespace :rails do
  desc 'Restart the container'
  task :restart do
    on roles(:back) do
      within release_path do
        execute 'docker-compose', "-f #{fetch :docker_file}", :restart, 'back'
      end
    end
  end

  desc 'Create the database if it does not already exists'
  task :create do
    on roles(:back) do
      within release_path do
        sleep 10
        execute 'docker-compose', "-f #{fetch :docker_file}", :run, 'back', 'rake db:create'
      end
    end
  end

  desc 'Run the database migrations'
  task :migrate do
    on roles(:back) do
      within release_path do
        execute 'docker-compose', "-f #{fetch :docker_file}", :run, 'back', 'rake db:migrate'
      end
    end
  end

  desc 'Generate fake data'
  task :seed do
    on roles(:back) do
      within release_path do
        execute 'docker-compose', "-f #{fetch :docker_file}", :run, 'back', 'rake db:seed'
      end
    end
  end
end
