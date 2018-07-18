## Base image
FROM tensorflow/tensorflow:latest-gpu-py3

## Pick up some TF dependencies
RUN apt update 
RUN apt install -y curl 
RUN apt install -y wget 
RUN apt install -y axel 
RUN apt install -y ssh 
RUN apt install -y vim 
RUN apt install -y git 
RUN apt install -y python3-pip
RUN apt install -y python-pydot python-pydot-ng graphviz
RUN apt clean 
RUN rm -rf /var/lib/apt/lists/*

RUN pip3 install numpy

RUN pip3 install pydot
## Jupyter setting
RUN pip3 install https://github.com/ipython-contrib/jupyter_contrib_nbextensions/tarball/master
RUN pip3 install jupyter_nbextensions_configurator 
RUN jupyter contrib nbextension install --user 
RUN jupyter nbextension enable hinterland/hinterland 
RUN jupyter nbextension enable varInspector/main 
RUN jupyter nbextension enable snippets_menu/main 
RUN jupyter nbextension enable runtools/main 
RUN jupyter nbextension enable scroll_down/main 
RUN jupyter nbextension enable codefolding/main 
RUN jupyter nbextension enable execute_time/ExecuteTime 

## Install PyTorch
RUN pip3 install http://download.pytorch.org/whl/cu91/torch-0.4.0-cp35-cp35m-linux_x86_64.whl 
RUN pip3 install torchvision


# Define working directory.
WORKDIR /notebooks
RUN pip3 install keras
RUN echo 'cd /notebooks' >> ~/.bashrc
RUN sed -i -e 's/prohibit-password/yes/g' /etc/ssh/sshd_config 
RUN echo '/etc/init.d/ssh restart' > /notebooks/restartSSH.sh

COPY .bashrc /root/
