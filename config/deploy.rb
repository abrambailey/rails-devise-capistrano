# config valid only for current version of Capistrano
lock '3.4.0'

# Application
# ===========
set :application, 'rails-devise-capistrano'
set :deploy_to, '/var/www/rails-devise-capistrano'
set :linked_files, %w{config/database.yml}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

set :rbenv_ruby, File.read('.ruby-version').strip

# Hosts
# ===========
role :web, "localhost" 
# role :app, %w{example.com}
# role :db,  %w{example.com}

# Git
# ===
set :scm, :git
set :branch, "master"
set :deploy_via, :export
set :repo_url, 'git@github.com:abrambailey/rails-devise-capistrano.git'

# SSH
# ===
set :ssh_options, {user: 'vagrant', port: 2222, keys: ['~/.vagrant.d/insecure_private_key']}

# Capistrano
# ==========
set :format, :pretty
set :log_level, :debug
set :keep_releases, 7

# role :admin, "vagrant@localhost"

# task :setup_db do
#   on roles(:admin) do
#     execute :touch, "#{release_path}/config/database.yml"
#     execute :ln, "-nfs #{shared_path}/config/settings.yml #{release_path}/config/settings.yml"
#     execute :ln, "-nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
#     execute :ln, "-fs #{shared_path}/uploads #{release_path}/uploads"
#   end
# end

# before "deploy:assets:precompile", :setup_db

namespace :deploy do
  desc "Restart application"
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join("tmp/restart.txt")
    end
  end
  after :finishing, "deploy:cleanup"
end