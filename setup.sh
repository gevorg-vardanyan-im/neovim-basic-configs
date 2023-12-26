# This script will install neovim from snap store,
# install neovim required python packages,
# clipboard integration package, etc.

# install neovim from snap store
sudo snap install nvim --classic

# install required python packages
pip3 install --upgrade pip
python3 -m pip install --user --upgrade pynvim

# clipboard integration
sudo apt-get update
sudo apt-get -y install xsel

