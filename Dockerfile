FROM minedojo/minedojo:latest

RUN sudo apt-get update \
    && sudo apt-get upgrade -y \
    && sudo rm -rf /var/lib/apt/lists/*

COPY --chown=user:user \
     MineCLIP /home/user/MineCLIP
RUN pip install -e /home/user/MineCLIP

RUN sudo /opt/conda/bin/pip uninstall -y minedojo
RUN pip uninstall -y minedojo
COPY --chown=user:user \
     MineDojo /home/user/MineDojo
RUN pip install -e /home/user/MineDojo

COPY --chown=user:user \
     requirements.txt /home/user/requirements.txt
RUN pip install -r requirements.txt

# For ease of debugging, should be removed
RUN sudo apt-get update
