# config valid only for current version of Capistrano
lock '3.4.0'

# set :rails_env, "production"
# set :deploy_to, "/data/projects/"
set :rbenv_ruby, File.read('.ruby-version').strip
set :application, 'rails-devise-capistrano'
set :repo_url, 'git@github.com:abrambailey/rails-devise-capistrano.git'

set :ssh_options, {user: 'vagrant', port: 2222, keys: ['~/.vagrant.d/insecure_private_key']}
role :web, "localhost" 

set :log_level, :info

set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads')
set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

# SSHKit.config.command_map[:rake]  = "bundle exec rake" #8
# SSHKit.config.command_map[:rails] = "bundle exec rails"

set :keep_releases, 20

namespace :deploy do

  desc "Restart application"
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join("tmp/restart.txt")
    end
  end

  after :finishing, "deploy:cleanup"

end