FROM debian

RUN apt-get update
RUN apt-get install sudo
RUN echo "bin:pass" | chpasswd

RUN whoami
#USER 2
#RUN whoami

COPY dependencies.sh /dependencies.sh

ENTRYPOINT ["bash", "/dependencies.sh"]

#CMD ["/bin/bash"]


