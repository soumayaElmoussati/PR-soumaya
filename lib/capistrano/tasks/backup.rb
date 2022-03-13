namespace :backup do
  desc 'Create a backup'
  task :create do
    on roles(:back) do
      within release_path do
        execute 'docker-compose', "-f #{fetch :docker_file}", :exec, '-T', :db, :bash, '-c "backup perform --trigger production_backup"'
      end
    end
  end
end
