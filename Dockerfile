# Dockerfile
FROM python:3.9.10-alpine3.14

# SSH password
ENV SSH_PASSWD "root:Docker!"

COPY ./requirements.txt /app/requirements.txt
WORKDIR /app
RUN pip install -r requirements.txt
COPY . /app
COPY sshd_config /etc/ssh/

# Install needed packages for SSH
RUN apk update
RUN apk add dialog
RUN apk update
RUN apk add openssh-server
RUN echo "$SSH_PASSWD" | chpasswd
# RUN chmod +x /app/init_container.sh

#Expose Port
EXPOSE 8000 2222

# Run the bash script to start Flask
ENTRYPOINT [ "/app/init_container.sh" ]