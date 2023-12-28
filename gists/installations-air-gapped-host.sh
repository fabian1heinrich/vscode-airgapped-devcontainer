sudo apt install ./downloads/code_1.85.0-1701895805_arm64.deb
extensions=(downloads/extensions/*)
for extension in "${extensions[@]}"; 
do
  code --install-extension $extension
done

tar xzvf downloads/docker-24.0.7.tgz
sudo cp docker/* /usr/bin
rm -r docker/
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker
sudo dockerd &