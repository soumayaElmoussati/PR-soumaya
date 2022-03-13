namespace :docker do
  desc 'Build the images'
  task :build_db do
    on roles(:back) do
      within release_path do
        execute 'docker-compose', "-f #{fetch :docker_file}", :build, '--force-rm', 'db'
      end
    end
  end

  desc 'Build the images'
  task :build do
    on roles(:front) do
      within release_path do
        execute 'docker-compose', "-f #{fetch :docker_file}", :build, '--force-rm', 'front'
      end
    end

    on roles(:back) do
      within release_path do
        execute 'docker-compose', "-f #{fetch :docker_file}", :build, '--force-rm', 'db'
        execute 'docker-compose', "-f #{fetch :docker_file}", :build, '--force-rm', 'back'
      end
    end
  end

  desc 'Start the containers'
  task :up do
    on roles(:front) do
      within release_path do
        execute 'docker-compose', "-f #{fetch :docker_file}", :up, '-d front'
      end
    end

    on roles(:back) do
      within release_path do
        execute 'docker-compose', "-f #{fetch :docker_file}", :up, '-d back'
      end
    end
  end

  desc 'Stop all the containers'
  task :down do
    on roles(:back, :front) do
      within release_path do
        execute 'docker-compose', "-f #{fetch :docker_file}", :down
        execute 'docker', :stop, '$(docker ps -a -q)'
        execute 'docker', :network, :prune, '-f'
      end
    end
  end
end