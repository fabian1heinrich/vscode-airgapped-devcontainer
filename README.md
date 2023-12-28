# VS Code Air-Gapped Dev Container

## Preparations on Online Host

### Download Docker and VS Code

```bash
mkdir -p downloads
wget -P downloads/ https://download.docker.com/linux/static/stable/aarch64/docker-24.0.7.tgz
wget -P downloads/ https://vscode.download.prss.microsoft.com/dbazure/download/stable/af28b32d7e553898b2a91af498b1fb666fdebe0c/code_1.85.0-1701895805_arm64.deb
```

### Download VS Code Extensions

```bash
extensions=(
  "ms-python.python@2023.22.1"  
  "ms-python.vscode-pylance@2023.12.1"  
  "ms-toolsai.jupyter@2023.11.1003402403"  
  "ms-toolsai.jupyter-keymap@1.1.2"  
  "ms-toolsai.jupyter-renderers@1.0.17"  
  "ms-toolsai.vscode-jupyter-cell-tags@0.1.8"  
  "ms-toolsai.vscode-jupyter-slideshow@0.1.5"  
  "ms-vscode-remote.remote-containers@0.327.0"  
  "ms-vscode-remote.remote-ssh@0.107.1"  
  "ms-vscode-remote.remote-ssh-edit@0.86.0"  
  "ms-vscode-remote.vscode-remote-extensionpack@0.25.0"  
  "ms-vscode.live-server@0.4.13"  
  "ms-vscode.remote-explorer@0.4.1"  
  "ms-vscode.remote-server@1.5.0"
)

mkdir -p downloads/extensions
for extension in "${extensions[@]}"
do
  extension_string="$(echo ${extension} | cut -d "@" -f 1)"
  version="$(echo ${extension} | cut -d "@" -f 2)"
  publisher="$(echo $extension_string | cut -d "." -f 1)"
  extension="$(echo $extension_string | cut -d "." -f 2)"
  (cd downloads/extensions && \
  curl -O https://${publisher}.gallery.vsassets.io/_apis/public/gallery/publisher/${publisher}/extension/${extension}/${version}/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage && \
  mv Microsoft.VisualStudio.Services.VSIXPackage ${publisher}.${extension}.vsix )
done
```

### Build Dev Container Image

```bash
docker build -f .devcontainer/Dockerfile -t devcontainer:latest . --build-arg COMMIT_ID=af28b32d7e553898b2a91af498b1fb666fdebe0c
```

## On Air-Gapped Host

- switch off network if you use VM like I do

### Install VS Code and Extensions

```bash
sudo apt install ./downloads/code_1.85.0-1701895805_arm64.deb
extensions=(downloads/extensions/*)
for extension in "${extensions[@]}"; 
do
  code --install-extension $extension
done
```

### Install Docker

```bash
tar xzvf downloads/docker-24.0.7.tgz
sudo cp docker/* /usr/bin
rm -r docker/
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker
sudo dockerd &
```

### Dev Container Setup

- transfer image and load image to locally cached docker images
- change VS Code setting remote.SSH.localServerDownload to "always"
- rebuild the image with the Dev Container Extension
  