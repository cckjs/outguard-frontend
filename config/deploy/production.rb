set :deploy_to, -> { "/var/www/wxdc/apps/#{fetch(:application)}" }
server 'www-data@42.96.175.44', roles: %w[web app db], primary: true, sidekiq: true, whenever: true

# bundle_env_variables[:http_proxy] = bundle_env_variables[:https_proxy] = "http://p.wido.me:8123"
# bundle_env_variables[:http_proxy] = bundle_env_variables[:https_proxy] = "http://10.144.145.112:13128"
