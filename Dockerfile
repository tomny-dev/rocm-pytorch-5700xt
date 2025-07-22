# ROCm 5.2.3 PyTorch Base for AMD GPUs (e.g., RX 5700 XT / GFX1030)
FROM ubuntu:20.04 as rocm-pytorch-5700xt

LABEL maintainer="you@example.com"

ENV DEBIAN_FRONTEND=noninteractive

# Add deadsnakes PPA and install Python 3.10
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        software-properties-common && \
    add-apt-repository ppa:deadsnakes/ppa && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        python3.10 python3.10-venv python3.10-dev python3-pip && \
    update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.10 1 && \
    ln -sf /usr/bin/python3.10 /usr/bin/python

# Install Python 3.10 without pip, then install pip manually to avoid system pip issues
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        software-properties-common wget curl gnupg2 ca-certificates lsb-release \
        python3.10 python3.10-venv python3.10-dev && \
    update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.10 1 && \
    ln -sf /usr/bin/python3.10 /usr/bin/python && \
    curl -sS https://bootstrap.pypa.io/get-pip.py | python3.10 && \
    python3 --version && pip3 --version

# Install ROCm dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    wget gnupg2 curl ca-certificates lsb-release software-properties-common \
    && echo 'deb [arch=amd64] https://repo.radeon.com/rocm/apt/5.2/ ubuntu main' | tee /etc/apt/sources.list.d/rocm.list \
    && wget -qO - https://repo.radeon.com/rocm/rocm.gpg.key | apt-key add - \
    && apt-get update && apt-get install -y --no-install-recommends \
    rocm-smi rocm-utils rocminfo hip-runtime-amd \
    git ffmpeg unzip libgl1 libjemalloc2 \
    && rm -rf /var/lib/apt/lists/*

ENV PATH=/opt/rocm/bin:$PATH

# Install PyTorch with ROCm 5.2.3 compatibility
RUN python3 -m pip install \
      torch==1.13.1+rocm5.2 \
      torchvision==0.14.1+rocm5.2 \
      torchaudio==0.13.1 \
      --extra-index-url https://download.pytorch.org/whl/rocm5.2

ENV HSA_OVERRIDE_GFX_VERSION=10.3.0

CMD ["/bin/bash"]