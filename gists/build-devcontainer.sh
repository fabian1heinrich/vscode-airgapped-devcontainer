docker build -f .devcontainer/Dockerfile -t devcontainer:latest . --build-arg COMMIT_ID=af28b32d7e553898b2a91af498b1fb666fdebe0c
docker save devcontainer:latest > devcontainer-latest.tar

# docker buildx build -f .devcontainer/Dockerfile -t devcontainer:latest . --build-arg COMMIT_ID=af28b32d7e553898b2a91af498b1fb666fdebe0c --platform linux/amd64
