set :stage, :production
server '127.0.0.1', user: 'vagrant', roles: %w{web}
role :admin, "vagrant@localhost"