set -e

echo "Installing required packages"
sudo apt-get update
sudo apt-get install -y make git vim

echo "Installing ruby-build"
git clone https://github.com/sstephenson/ruby-build.git
./ruby-build/install.sh

version=$(ruby-build --definitions | grep 1.9.3 | tail -1)
echo "Installing ruby-${version}"
ruby-build "$(ruby-build --definitions | grep 1.9.3 | tail -1)" /home/vagrant/local/ruby-${version}

echo "Installing dot files"
git clone https://github.com/gsabev/dotfiles.git
cp -rf ./dotfiles/.[a-zA-Z0-9]* /home/vagrant
cp -rf ./dotfiles/git-completion.bash

echo "Fixing permissions and ownership"
chmod 0600 /home/vagrant/.ssh/id_*
chown -R vagrant:vagrant /home/vagrant

echo "Tuning environment"
echo "export PATH=/home/vagrant/local/ruby-${version}/bin/:\$PATH" >> /home/vagrant/.bashrc
echo 'vagrant  ALL= (ALL:ALL) NOPASSWD: ALL' >> /etc/sudoers

echo "Installing basic gems"
sudo -iu vagrant gem install pry
sudo -iu vagrant gem install bundler
