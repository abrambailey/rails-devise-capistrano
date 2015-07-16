# config valid only for current version of Capistrano
lock '3.4.0'

# Application
# ===========
set :application, 'rails-devise-capistrano'
set :deploy_to, '/var/www/rails-devise-capistrano'
set :linked_files, %w{config/database.yml}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}
set :rbenv_ruby, File.read('.ruby-version').strip
# set :bundle_env_variables, { nokogiri_use_system_libraries: 1 }
set :bundle_flags, ''

set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}
# set :passenger_restart_with_sudo, true

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
set :log_level, :info
set :keep_releases, 7

# task :setup_db do
#   on roles(:admin) do
#     execute :ln, "-nfs #{shared_path}/config/settings.yml #{release_path}/config/settings.yml"
#     execute :ln, "-nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
#     execute :ln, "-fs #{shared_path}/uploads #{release_path}/uploads"
#   end
# end

# before "deploy:assets:precompile", :setup_db

namespace :deploy do
  after :restart, :restart_passenger do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      within release_path do
        execute :touch, 'tmp/restart.txt'
      end
    end
  end
  after :finishing, 'deploy:restart_passenger'
end