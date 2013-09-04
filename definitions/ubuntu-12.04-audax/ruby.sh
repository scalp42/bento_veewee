apt-get -y install libyaml-0-2 libyaml-dev

# Install Ruby from source in /opt for Vagrant users
RUBY_VERSION=1.9.3-p448
wget https://ftp.ruby-lang.org/pub/ruby/1.9/ruby-$RUBY_VERSION.tar.gz
tar xvzf ruby-$RUBY_VERSION.tar.gz
cd ruby-$RUBY_VERSION
./configure --prefix=/opt/ruby
make
make install
cd ..
rm -rf ruby-$RUBY_VERSION

# Install Rubygems 2.0.7
RUBYGEMS_VERSION=2.0.7
wget http://production.cf.rubygems.org/rubygems/rubygems-$RUBYGEMS_VERSION.tgz
tar xzf rubygems-$RUBYGEMS_VERSION.tgz
cd rubygems-$RUBYGEMS_VERSION
/opt/ruby/bin/ruby setup.rb
cd ..
rm -rf rubygems-$RUBYGEMS_VERSION

# Add /opt/ruby/bin to the global path as the last resort so
# Ruby, RubyGems, and Chef are visible
echo 'PATH=$PATH:/opt/ruby/bin/'> /etc/profile.d/vagrantruby.sh
