FROM ubuntu:20.04
ENV DEBIAN_FRONTEND=noninteractive 
RUN apt-get update && apt-get install -y wget openjdk-8-jdk libpq-dev ghostscript python3-pip
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && apt install -y ./google-chrome-stable_current_amd64.deb
RUN useradd -s /bin/bash -m  anvil
COPY baseconfig.yml /app/baseconfig.yml
RUN mkdir -p /app
RUN chown anvil:anvil /app/baseconfig.yml && chown anvil:anvil -R /app
USER anvil
RUN pip3 install anvil-app-server anvil-uplink
WORKDIR /app
RUN mkdir -p data && mkdir -p current
RUN /home/anvil/.local/bin/anvil-app-server --help || true
VOLUME /app/data
VOLUME /app/current
RUN KEY=$(echo $RANDOM | md5sum | head -c 20; echo;) && echo "uplink-key: ${KEY}" >> /app/baseconfig.yml
COPY docker-entrypoint.sh /
CMD /docker-entrypoint.sh
