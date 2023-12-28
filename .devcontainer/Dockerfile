FROM mcr.microsoft.com/vscode/devcontainers/python:3.10-bullseye

ARG COMMIT_ID=af28b32d7e553898b2a91af498b1fb666fdebe0c
ARG TARGETARCH

WORKDIR /home/vscode/airgapped-devcontainer
COPY requirements.txt . 
RUN pip install -r requirements.txt

WORKDIR /home/vscode/.vscode-server/bin
RUN case ${TARGETARCH} in \
        "amd64") ARCHITECTURE="x64" ;; \
        "arm64") ARCHITECTURE="arm64" ;; \
        *) exit 1 ;; \
    esac && \
    wget https://update.code.visualstudio.com/commit:${COMMIT_ID}/server-linux-${ARCHITECTURE}/stable && tar xf stable && mv vscode-server-linux-${ARCHITECTURE} "${COMMIT_ID}"
RUN chown -R vscode: /home/vscode/.vscode-server