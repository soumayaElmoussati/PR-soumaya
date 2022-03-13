namespace :nginx do
  desc 'Copy configuration'
  task :copy do
    on roles(:front) do
      within release_path do
        upload! "apps/nginx/www.#{fetch :nginx_env}.conf" , '/etc/nginx/sites-available/default'
      end
    end
    on roles(:back) do
      within release_path do
        upload! "apps/nginx/api.#{fetch :nginx_env}.conf" , '/etc/nginx/sites-available/default'
      end
    end
  end

  desc 'Restart configuration'
  task :restart do
    on roles(:all) do
      within release_path do
        execute 'service', :nginx, :restart
      end
    end
  end
end