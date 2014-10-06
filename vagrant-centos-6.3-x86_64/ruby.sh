# Install Ruby

#####
## Commented attempt at installing RVM to bootstrap the ruby installation
## Ran into path issues.  Perhaps resolved by disabling use of the sudoers
## secure_path for veewee, but it was quick to just install from source.
#
#yum -y install ruby ruby-devel rubygems
#curl -L get.rvm.io | sudo bash -s stable
#source /etc/profile.d/rvm.sh
#/usr/local/rvm/bin/rvmsudo yum install -y gcc-c++ patch readline readline-devel zlib zlib-devel libffi-devel openssl-devel make bzip2 autoconf automake libtool bison
#/usr/local/rvm/bin/rvmsudo /usr/local/rvm/bin/rvm install 1.9.3
#####

cd ~
wget http://pyyaml.org/download/libyaml/yaml-0.1.4.tar.gz
tar xzf yaml-0.1.4.tar.gz
cd yaml-0.1.4
./configure --prefix=/usr/local
make
sudo make install

cd ~
wget http://ftp.ruby-lang.org/pub/ruby/1.9/ruby-1.9.3-p327.tar.gz
tar xzf ruby-1.9.3-p327.tar.gz
cd ruby-1.9.3-p327
./configure
make
sudo make install

cd ~
rm -Rf yaml-0.1.4
rm -f yaml-0.1.4.tar.gz
rm -Rf ruby-1.9.3-p327
rm -f ruby-1.9.3-p327.tar.gz
