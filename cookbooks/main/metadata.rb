name 'brotodevbox'
maintainer 'brennovich'
maintainer_email 'brennolncosta@gmail.com'

%w(ubuntu debian).each do |os|
  supports os
end

depends 'apt'
depends 'openssl'
depends 'postgresql'
depends 'elasticsearch'
depends 'mysql'
depends 'heroku-toolbelt'
depends 'rbenv'
depends 'ruby_build'
