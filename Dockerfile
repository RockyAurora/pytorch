FROM pytorch/pytorch:2.1.2-cuda12.1-cudnn8-devel

RUN apt-key del 7fa2af80 && \
    apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/3bf863cc.pub && \
    apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu2004/x86_64/7fa2af80.pub
    
RUN apt-get update && apt-get install -y libgl1-mesa-glx libpci-dev curl nano psmisc zip git && apt-get --fix-broken install -y

RUN pip install -U pip
RUN pip install "numpy<1.24" cython
RUN pip install -U openmim
RUN mim install mmcv-full==1.7.2 -f https://download.openmmlab.com/mmcv/dist/cu121/torch2.1.0/index.html
RUN pip install mmsegmentation==0.30.0
RUN pip install matplotlib pycocotools scipy scikit-learn albumentations>=0.3.2 opencv-python shapely==2.0.6
RUN pip install pycocotools>=2.0.2 termcolor>=1.1 yacs>=0.1.8 cloudpickle tensorboard fvcore iopath omegaconf hydra_core black antlr4-python3-runtime portalocker mypy_extensions pathspec tensorboard_data_server google_auth_oauthlib grpcio absl_py google_auth protobuf werkzeug>=1.0.1 rsa pyasn1-modules>=0.2.1 cachetools requests-oauthlib>=0.7.0 pyasn1 oauthlib>=3.0.0 MarkupSafe>=2.1.1 appdirs pyquaternion coloredlogs typing humanfriendly>=9.1 timm h5py submitit scikit-image huggingface_hub safetensors tifffile>=2022.8.12 imageio>=2.27 networkx>=2.8 PyWavelets>=1.1.1 lazy_loader>=0.2 fsspec>=2023.5.0 jaxtyping==0.2.11 jinja2==2.11.3 transformers==4.40.2 triton==3.3.1 dill seaborn polars cython==0.29.33
RUN git clone https://github.com/open-mmlab/mmdetection.git /mmdetection
WORKDIR /mmdetection
RUN pip install -v -e .
WORKDIR /workspace
RUN python -c "import numpy; print(f'numpy版本: {numpy.__version__}')"
