set :application, "agrivillage"
set :repo_url, "git@github.com:WilliamDASILVA/agrivillage.git"

# Default value for :linked_files is []
append :linked_files, "apps/back/config/master.key", "apps/back/config/credentials.yml.enc", ".env"

# Default value for linked_dirs is []
append :linked_dirs, "apps/back/log", "apps/back/tmp/pids", "apps/back/tmp/db"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
set :keep_releases, 3

set :slackistrano, {
  klass: Slackistrano::CustomMessaging,
  channel: '#general',
  webhook: 'https://hooks.slack.com/services/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',
  username: 'AgriVillage',
  icon_url: 'https://www.agrivillage.fr/icon.png'
}

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure
