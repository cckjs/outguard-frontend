set :application, 'newswire'

set :rbenv_ruby, '2.2.3'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :rbenv_roles, :all

fetch(:linked_files).concat %w(
  config/database.yml
  config/secrets.yml
)

# fetch(:linked_dirs).concat %w(
#   public/uploads
#   tmp/jobs
# )
