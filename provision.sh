sudo apt-get update
sudo apt-get install -y make git vim
git clone https://github.com/sstephenson/ruby-build.git
./ruby-build/install.sh
gem install bundler
ruby-build "$(ruby-build --definitions | grep 1.9.3 | tail -1)" /home/vagrant/local/ruby-$(ruby-build --definitions | grep 1.9.3 | tail -1)
echo "export PATH=/home/vagrant/local/ruby-1.9.3-p547/bin/:\$PATH" >> /home/vagrant/.bashrc
