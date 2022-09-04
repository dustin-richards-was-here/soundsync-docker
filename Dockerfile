FROM ubuntu:22.04

ADD https://soundsync.app/download/soundsync-deb-x64.deb /

# avoid prompts for tzdata
ENV TZ=America/Denver
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# avoid prompts for keyboard-configuration
ENV DEBIAN_FRONTEND=noninteractive

RUN apt update
RUN apt install /soundsync-deb-x64.deb --yes
RUN apt install xdg-utils pulseaudio-utils --yes

# Set up the user
ENV UNAME pacat

RUN export UNAME=$UNAME UID=1000 GID=1000 && \
    mkdir -p "/home/${UNAME}" && \
    echo "${UNAME}:x:${UID}:${GID}:${UNAME} User,,,:/home/${UNAME}:/bin/bash" >> /etc/passwd && \
    echo "${UNAME}:x:${UID}:" >> /etc/group && \
    mkdir -p /etc/sudoers.d && \
    echo "${UNAME} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/${UNAME} && \
    chmod 0440 /etc/sudoers.d/${UNAME} && \
    chown ${UID}:${GID} -R /home/${UNAME} && \
    gpasswd -a ${UNAME} audio

COPY pulse-client.conf /etc/pulse/client.conf

USER $UNAME
ENV HOME /home/pacat

CMD /opt/Soundsync/soundsync
