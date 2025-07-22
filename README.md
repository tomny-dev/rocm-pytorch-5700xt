# ROCm PyTorch Base for AMD RX 5700 XT (GFX1030)

This image provides a Docker base environment with ROCm 5.2.3 and PyTorch 1.13.1 for AMD GPUs — specifically tuned for compatibility with the **AMD Radeon RX 5700 XT** (`gfx1030` architecture).

It serves as a foundation for deploying ROCm-based deep learning models like [Stable Diffusion Next (SD.Next)](https://github.com/vladmandic/sdnext) on AMD GPUs.

## ✅ Features

- Ubuntu 20.04
- ROCm 5.2.3 toolchain
- PyTorch 1.13.1 + ROCm 5.2.3 wheels
- Compatible with AMD RX 5700 XT / GFX1030
- Ideal for image generation and machine learning apps using ROCm

## 🐳 Usage

```bash
docker pull ghcr.io/tomny-dev/rocm-pytorch-5700xt:latest
```

Or use it as a base in your own Dockerfile:

```dockerfile
FROM ghcr.io/tomny-dev/rocm-pytorch-5700xt:latest
```