declare -A installed_packages=()
declare -A packages=(
  ["node"]="snap node --classic --channel=12"
  ["code"]="snap code --classic"
  ["postman"]="snap postman"
  ["cmake"]="snap cmake --classic"
  ["clion"]="snap clion --classic"
  ["datagrip"]="snap datagrip --classic"
  ["intellij-idea-ultimate"]="snap intellij-idea-ultimate --classic"
  ["webstorm"]="snap webstorm --classic"
  ["pycharm-professional"]="snap pycharm-professional --classic"
  ["android-studio"]="snap android-studio --classic"
  ["default-jdk"]="apt default-jdk -y -qq"
  ["openjdk-8-jdk"]="apt openjdk-8-jdk -y -qq"
  ["openjdk-11-jdk"]="apt openjdk-11-jdk -y -qq"
  ["openjdk-13-jdk"]="apt openjdk-13-jdk -y -qq"
  ["neovim"]="apt neovim -y -qq"
  ["pip3"]="apt python3-pip -y -qq"
  ["git"]="apt git -y -qq"
  ["gnome-tweaks"]="apt gnome-tweaks -y -qq"
  ["dash-to-dock"]="apt gnome-shell-extension-dashtodock -y -qq"
)

export installed_packages;
export packages;
