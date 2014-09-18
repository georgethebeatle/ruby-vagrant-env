set -e

echo "Installing required packages"
sudo apt-get update
sudo apt-get install -y make git

echo "Cloning vim sources"
git clone https://github.com/b4winckler/vim.git
echo "Compiling vim with ruby support"
(cd vim && ./configure --enable-rubyinterp && make && sudo make install)

echo "Installing ruby-build"
git clone https://github.com/sstephenson/ruby-build.git
./ruby-build/install.sh

version=$(ruby-build --definitions | grep 1.9.3 | tail -1)
echo "Installing ruby-${version}"
ruby-build "$(ruby-build --definitions | grep 1.9.3 | tail -1)" /home/vagrant/local/ruby-${version}

echo "Installing dot files"
git clone https://github.com/gsabev/dotfiles.git
cp -rf ./dotfiles/.[a-zA-Z0-9]* /home/vagrant
cp -rf ./dotfiles/git-completion.bash /home/vagrant

echo "Installing Vundle vim plugin"
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

echo "Generating key pair"
rm -rf ~/.ssh/id_* && ssh-keygen -t rsa -P '' -f '/home/vagrant/.ssh/id_rsa'

echo "Fixing ownership"
chown -R vagrant:vagrant /home/vagrant

echo "Tuning environment"
echo "export PATH=/home/vagrant/local/ruby-${version}/bin/:\$PATH" >> /home/vagrant/.bashrc
echo 'vagrant  ALL= (ALL:ALL) NOPASSWD: ALL' >> /etc/sudoers

echo "Installing basic gems"
sudo -iu vagrant gem install pry
sudo -iu vagrant gem install bundler

echo "Your public key is:"
cat /home/vagrant/.ssh/id_rsa.pub
