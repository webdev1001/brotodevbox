include_recipe 'apt'
include_recipe 'openssl'

node.set['platform'] = 'ubuntu'

node.set['apt']['unattended_upgrades']['enable'] = true
node.set['apt']['unattended_upgrades']['auto_fix_interrupted_dpkg'] = true

apt_repository 'neovim' do
  uri 'ppa:neovim-ppa/unstable'
  distribution node['lsb']['codename']
end

node.set['postgresql'] = {
  version: '9.4',
  dir: '/var/lib/postgresql/9.4/main',
  password: {
    postgres: ''
  },
  pg_hba: [
    {
      comment: '# Allow all local connections for `postgres`',
      type: 'local',
      db: 'all',
      user: 'postgres',
      addr: nil,
      method: 'trust'
    }
  ]
}

include_recipe 'postgresql::server'

node.default['rbenv']['user_installs'] = [ { 'user' => 'vagrant' } ]
node.set['ruby_build']['upgrade'] = true

include_recipe 'rbenv::user_install'
include_recipe 'ruby_build'

# Stuff that isn't being used
# node.set['heroku-toolbelt']['standalone'] = false
# include_recipe 'heroku-toolbelt'

# mysql_service 'default' do
#   port '3306'
#   version '5.6'
#   initial_root_password ''
#   bind_address '*'
#   action [:create, :start]
# end

%w(
  build-essential git-core subversion curl autoconf zlib1g-dev libssl-dev
  libreadline6-dev libxml2-dev libyaml-dev libapreq2-dev tmux memcached
  imagemagick libmagickwand-dev libxslt1-dev libxml2-dev libsqlite3-dev
  openjdk-7-jre-headless nfs-common libmysqlclient-dev libpq-dev libffi-dev
  libcurl4-openssl-dev libreadline-dev sqlite3 ack-grep nodejs exuberant-ctags
  neovim redis-server python-pip python-dev
).each do |package_name|
  package package_name do
    action :install
  end
end

include_recipe 'elasticsearch'

# Setup Dotfiles
bash 'clone dotfiles repo' do
  user 'vagrant'
  cwd '/home/vagrant/code'
  code 'git clone --recursive https://github.com/brennovich/dotfiles.git /home/vagrant/code/dotfiles'
  not_if { ::Dir.exist?('/home/vagrant/code/dotfiles') }
end

bash 'install dotfiles' do
  user 'vagrant'
  cwd '/home/vagrant/code/dotfiles'
  code 'rm -rf /home/vagrant/.bashrc /home/vagrant/.vim && HOME=/home/vagrant sh /home/vagrant/code/dotfiles/install.sh'
end

bash 'install neovim modules dependencies' do
  user 'root'
  code 'pip install neovim'
end
