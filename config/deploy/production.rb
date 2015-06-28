set :stage, :production

# Replace 127.0.0.1 with your server's IP address!
server '127.0.0.1', user: 'vagrant', roles: %w{web}