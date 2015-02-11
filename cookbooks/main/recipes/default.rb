include_recipe 'apt'
include_recipe 'openssl'

node.set['platform'] = 'ubuntu'

# Postgres
node.set['postgresql'] = {
  version: '9.4',
  password: {
    postgres: ''
  },
  dir: '/var/lib/postgresql/9.4/main',
  pg_hba: [
    {
      type: 'local',
      db: 'all',
      user: 'postgres',
      method: 'trust'
    }
  ]
}

# rbenv
node.default['rbenv']['user_installs'] = [ { 'user' => 'vagrant' } ]

# ruby-build
node.set['ruby_build']['upgrade'] = true

# Heroku Toolbelt
node.set['heroku-toolbelt']['standalone'] = false

include_recipe 'postgresql::server'
include_recipe 'rbenv::user_install'
include_recipe 'ruby_build'
include_recipe 'heroku-toolbelt'

mysql_service 'default' do
  port '3306'
  version '5.6'
  initial_root_password ''
  bind_address '*'
  action [:create, :start]
end

%w(
  build-essential git-core subversion curl autoconf zlib1g-dev libssl-dev
  libreadline6-dev libxml2-dev libyaml-dev libapreq2-dev vim tmux memcached
  imagemagick libmagickwand-dev libxslt1-dev libxml2-dev libsqlite3-dev
  openjdk-8-jre-headless nfs-common libmysqlclient-dev libpq-dev libffi-dev
  libcurl4-openssl-dev libreadline-dev sqlite3 ack-grep nodejs exuberant-ctags
).each do |package_name|
  package package_name do
    action :install
  end
end

include_recipe 'elasticsearch'

# Dotfiles
bash 'clone dotfiles repo' do
  user 'vagrant'
  cwd '/home/vagrant/code'
  code 'git clone https://github.com/brennovich/dotfiles.git /home/vagrant/code/dotfiles'
  not_if { ::File.exists?('/home/vagrant/code/dotfiles') }
end

bash 'install dotfiles' do
  user 'vagrant'
  cwd '/home/vagrant/code/dotfiles'
  code 'rm -rf /home/vagrant/.bashrc /home/vagrant/.vim && HOME=/home/vagrant sh /home/vagrant/code/dotfiles/install.sh'
  not_if { ::File.exists?('/home/vagrant/.vimrc') }
end

bash 'setup neobundle' do
  user 'vagrant'
  cwd '/home/vagrant/'
  code 'git clone git://github.com/Shougo/neobundle.vim /home/vagrant/.vim/bundle/neobundle.vim'
  not_if { ::File.exists?('/home/vagrant/.vim/bundle/neobundle.vim') }
end
