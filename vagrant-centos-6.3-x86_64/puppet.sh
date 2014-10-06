# Install Puppet

#cat > /etc/yum.repos.d/puppetlabs.repo << EOM
#[puppetlabs]
#name=puppetlabs
#baseurl=http://yum.puppetlabs.com/el/6/products/\$basearch
#enabled=1
#gpgcheck=0
#EOM
#
#yum -y install puppet facter

/usr/local/bin/gem install --no-ri --no-rdoc puppet
