FROM nvidia/cuda:11.2.2-runtime-ubuntu20.04
LABEL maintainer "NVIDIA CORPORATION <cudatools@nvidia.com>"

ENV PYTHON_VERSION="3.8.5"
ENV PYTHON_ENV_NAME="pytorch_docker_test"

ENV CUDNN_VERSION 8.1.1.33
LABEL com.nvidia.cudnn.version="${CUDNN_VERSION}"

ENV DEV="git curl wget build-essential gcc g++ make libffi-dev libssl-dev zlib1g-dev liblzma-dev libbz2-dev libreadline-dev libsqlite3-dev"
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get -y install $DEV

RUN apt-get install -y --no-install-recommends \
    libcudnn8=$CUDNN_VERSION-1+cuda11.2 \
    && apt-mark hold libcudnn8 && \
    rm -rf /var/lib/apt/lists/*

RUN echo "pyenv setupping ..." &&\
    git clone https://github.com/pyenv/pyenv.git ~/.pyenv &&\
    echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc &&\
    echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc && \
    echo 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> ~/.bashrc && \
    git clone https://github.com/pyenv/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv && \
    echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.bashrc

RUN echo "python installing ..." &&\
    ~/.pyenv/bin/pyenv install $PYTHON_VERSION && \
    ~/.pyenv/bin/pyenv virtualenv $PYTHON_VERSION $PYTHON_ENV_NAME

RUN ~/.pyenv/versions/$PYTHON_ENV_NAME/bin/python -m pip install --upgrade pip && \
    ~/.pyenv/versions/$PYTHON_ENV_NAME/bin/python -m pip install jupyter autopep8 flake8 pytest &&\
    ~/.pyenv/versions/$PYTHON_ENV_NAME/bin/python -m pip install torch torchvision