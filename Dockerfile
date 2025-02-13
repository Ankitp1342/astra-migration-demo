FROM cassandra:4.1.7
WORKDIR /usr/local/app

COPY startup.sh ./ 
COPY start_zdm.sh ./
COPY langflow_setup.py ./
COPY *.json ./ 
# Install the application dependencies
RUN wget https://bootstrap.pypa.io/get-pip.py
RUN apt-get update
RUN apt-get install python3-dev -y
RUN python3 get-pip.py
RUN apt-get install gcc-aarch64-linux-gnu -y 
RUN apt-get install vim -y
RUN pip install uv
RUN uv pip install langflow --system
RUN wget https://github.com/datastax/zdm-proxy/releases/download/v2.3.1/zdm-proxy-linux-amd64-v2.3.1.tgz 
RUN tar -xvf zdm-proxy-linux-amd64-v2.3.1.tgz
RUN mv zdm-proxy-v2.3.1 zdm
# RUNx cassandra -R

RUN sleep 20
# Copy in the source code
EXPOSE 7860
ENV LANGFLOW_HOST=0.0.0.0
ENV LANGFLOW_PORT=7860
ENV ZDM_PROXY_LISTEN_ADDRESS="0.0.0.0"
ENV ZDM_METRICS_ADDRESS="0.0.0.0"

ENV ZDM_ORIGIN_CONTACT_POINTS="127.0.0.1"
ENV ZDM_ORIGIN_USERNAME=""
ENV ZDM_ORIGIN_PASSWORD=""


# Setup an app user so the container doesn't run as the root user

CMD ["/usr/local/app/startup.sh"]
