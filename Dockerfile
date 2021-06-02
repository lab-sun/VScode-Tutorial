FROM nvidia/cuda:11.1-cudnn8-devel-ubuntu18.04

RUN \
  DEBIAN_FRONTEND=noninteractive apt-get update && \ 
  DEBIAN_FRONTEND=noninteractive apt-get install -y openssh-server && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y vim python3 python3-pip && \
  sed -i "s/UsePAM yes/#UsePAM yes/" /etc/ssh/sshd_config && \
  sed -i "s/PermitRootLogin/#PermitRootLogin/" /etc/ssh/sshd_config && \
  echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config && \
  echo 'UsePAM no' >> /etc/ssh/sshd_config && \
  echo 'service ssh start' >> /etc/bash.bashrc && \
  echo 'root:your_password' | chpasswd

RUN pip3 install --upgrade pip
RUN pip3 install setuptools>=40.3.0 

RUN pip3 install -U scipy scikit-learn
RUN pip3 install torch==1.7.1+cu110 torchvision==0.8.2+cu110 torchaudio===0.7.2 -f https://download.pytorch.org/whl/torch_stable.html
RUN pip3 install torchsummary
RUN pip3 install tensorboard==2.2.0
