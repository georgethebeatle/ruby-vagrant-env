RUBY_VERSION=2.1.3

set -e

echo "Installing required packages"
sudo apt-get update
# Clone vim repository and compile vim from spurce with ruby support
sudo apt-get install -y make cmake git wget unzip libncurses5-dev libgnome2-dev libgnomeui-dev \
    libgtk2.0-dev libatk1.0-dev libbonoboui2-dev \
    libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev \
    ruby-dev mercurial

echo "Cloning vim sources"
git clone https://github.com/b4winckler/vim.git
echo "Compiling vim with ruby support"
(cd vim && ./configure --with-features=huge --enable-multibyte --enable-rubyinterp --enable-pythoninterp --with-python-config-dir=/usr/lib/python2.7/config --enable-perlinterp --enable-luainterp --enable-gui=gtk2 --enable-cscope --prefix=/usr && make VIMRUNTIMEDIR=/usr/share/vim/vim74 && sudo make install)

echo "Installing ruby-build"
git clone https://github.com/sstephenson/ruby-build.git
./ruby-build/install.sh

version=$(ruby-build --definitions | grep $RUBY_VERSION | tail -1)
echo "Installing ruby-${version}"
ruby-build "$(ruby-build --definitions | grep $RUBY_VERSION | tail -1)" /home/vagrant/local/ruby-${version}

echo "Installing dot files"
git clone https://github.com/gsabev/dotfiles.git
cp -rf ./dotfiles/.[a-zA-Z0-9]* /home/vagrant
cp -rf ./dotfiles/git-completion.bash /home/vagrant
# clone Vundle inside .vim/bundle/Vundle.vim directory
# install plugins from .vimrc by executing 'vim +PluginInstall +qall'
wget https://github.com/gmarik/Vundle.vim/archive/master.zip
mkdir -p /home/vagrant/.vim/bundle/Vundle.vim
unzip master.zip -d /home/vagrant/.vim/bundle/Vundle.vim
cp -r /home/vagrant/.vim/bundle/Vundle.vim/Vundle.vim-master/* /home/vagrant/.vim/bundle/Vundle.vim
rm -rf /home/vagrant/.vim/bundle/Vundle.vim/Vundle.vim-master
vim +PluginInstall +qall

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
