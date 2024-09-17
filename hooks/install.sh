echo "$USER ALL=(ALL:ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/$USER
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt update
sudo apt install tmux zsh make gcc ripgrep unzip git neovim build-essential fd-find fzf guake pipx curl xsel
curl -sS https://starship.rs/install.sh | sh

# oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autocomplete
git clone --depth 1 -- https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone --depth 1 -- https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

git clone --depth 1 -- https://github.com/zykon2004/kickstart.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
# installs nvm (Node Version Manager)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.0/install.sh | bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# dot-files
cd
git clone git@github.com:zykon2004/dot-files.git
cd ~/dot-files/hooks/
./post-merge
cp post-merge ../.git/hooks
cp ../.zshrc ~/.zshrc
exec zsh

starship preset gruvbox-rainbow -o ~/.config/starship.toml
nvm install 20

# Tmux config
tmux -u
tmux source ~/.tmux.conf
tksv
# Run TPM

# IDEs
sudo snap install rustrover  --classic
sudo snap install pycharm-community  --classic

git config --global user.name "Robert"
git config --global user.email "zykon@pm.me"

pipx install ruff
pipx install poetry
pipx install pre-commit
pipx install bpytop

# Docker
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
# Run at restart
sudo systemctl enable docker.service
sudo systemctl enable containerd.service
