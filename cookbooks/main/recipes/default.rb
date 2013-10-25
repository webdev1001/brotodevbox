include_recipe 'apt'
include_recipe 'openssl'

node.set['platform'] = 'ubuntu'

# Postgres
node.set['postgresql'] = {
  version: "9.3",
  enable_pgdg_apt: true,
  contrib: {
    packages: "postgresql-contrib-9.3"
  },
  password: {
    postgres: ''
  },
  pg_hba: [
    {
      type: 'local',
      db: 'all',
      user: 'postgres',
      method: 'trust'
    }
  ]
}

# Mysql
node.set['mysql'] = {
  server_root_password: '',
  server_repl_password: '',
  server_debian_password: '',
  allow_remote_root: true,
  bind_address: '*',

  client: {
    packages: ['libmysqlclient-dev']
  }
}

# rbenv
node.default['rbenv']['user_installs'] = [ { 'user' => 'vagrant' } ]

# Heroku Toolbelt
node.set['heroku-toolbelt']['standalone'] = false

include_recipe 'postgresql::server'
include_recipe 'mysql::server'
include_recipe 'mysql::client'
include_recipe 'rbenv::user_install'
include_recipe 'ruby_build'
include_recipe 'heroku-toolbelt'

# Packages
%w(
  build-essential git-core subversion curl autoconf zlib1g-dev libssl-dev
  libreadline6-dev libxml2-dev libyaml-dev libapreq2-dev vim tmux memcached
  imagemagick libmagickwand-dev libxslt1-dev libxml2-dev sphinxsearch
  libsqlite3-dev
).each do |package_name|
  package package_name do
    action :install
  end
end

# Dotfiles
bash 'clone dotfiles repo' do
  user 'vagrant'
  cwd '/home/vagrant/code'
  code 'git clone https://github.com/brennovich/dotfiles.git /home/vagrant/code/dotfiles'
  not_if { ::File.exists?('/home/vagrant/code') }
end

bash 'install dotfiles' do
  user 'vagrant'
  cwd '/home/vagrant/code/dotfiles'
  code 'rm /home/vagrant/.bashrc && HOME=/home/vagrant sh /home/vagrant/code/dotfiles/install.sh'
  not_if { ::File.exists?('/home/vagrant/.vimrc') }
end

bash 'setup neobundle' do
  user 'vagrant'
  cwd '/home/vagrant/'
  code 'git clone git://github.com/Shougo/neobundle.vim /home/vagrant/.vim/bundle/neobundle.vim'
  not_if { ::File.exists?('/home/vagrant/.vim/bundle/neobundle.vim') }
end
