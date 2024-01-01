FROM nvidia/cuda:11.2.2-cudnn8-runtime-ubuntu20.04

# Install Whisper
WORKDIR /usr/src
ARG INSTALL_WHISPER_COMMAND="git+https://github.com/baudneo/wyoming-faster-whisper.git@hf_asr_models"
RUN \
    apt-get update \
    && apt-get install -y --no-install-recommends \
        build-essential \
        python3 \
        python3-dev \
        python3-pip \
    \
    && pip3 install --no-cache-dir -U \
        setuptools \
        wheel \
    && pip3 install --no-cache-dir \
        "${INSTALL_WHISPER_COMMAND}" \
    \
    && apt-get purge -y --auto-remove \
        build-essential \
        python3-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /
COPY run.sh ./

EXPOSE 10300

ENTRYPOINT ["bash", "/run.sh"]
