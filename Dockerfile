# ROCm 5.2.3 PyTorch Base for AMD GPUs (e.g., RX 5700 XT / GFX1030)
FROM ubuntu:20.04 as rocm-pytorch-5700xt

LABEL maintainer="you@example.com"

ENV DEBIAN_FRONTEND=noninteractive

# Install ROCm dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    wget gnupg2 curl ca-certificates lsb-release software-properties-common \
    && echo 'deb [arch=amd64] https://repo.radeon.com/rocm/apt/5.2/ ubuntu main' | tee /etc/apt/sources.list.d/rocm.list \
    && wget -qO - https://repo.radeon.com/rocm/rocm.gpg.key | apt-key add - \
    && apt-get update && apt-get install -y --no-install-recommends \
    rocm-smi rocm-utils rocminfo hip-runtime-amd \
    git ffmpeg unzip libgl1 libjemalloc2 python3 python3-pip python3-venv \
    && rm -rf /var/lib/apt/lists/*

ENV PATH=/opt/rocm/bin:$PATH

# Install PyTorch with ROCm 5.2.3 compatibility
RUN python3 -m pip install --upgrade pip && \
    python3 -m pip install \
      torch==1.13.1+rocm5.2 \
      torchvision==0.14.1+rocm5.2 \
      torchaudio==0.13.1 \
      --extra-index-url https://download.pytorch.org/whl/rocm5.2

ENV HSA_OVERRIDE_GFX_VERSION=10.3.0

ARG VIDEO_GID=104
RUN groupadd -g ${VIDEO_GID} video && usermod -aG video root

CMD ["/bin/bash"]