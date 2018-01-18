FROM node:6.2

ENV NODE_ENV production
ENV MM_PORT 3000
ENV INSTALL_DIR /opt/simple-podcast-server

WORKDIR $INSTALL_DIR

RUN git clone --depth 1 -b master https://fullbright@github.com/fullbright/simple-podcast-server.git .

#RUN cp -R modules /opt/magic_mirror/unmount_modules
#RUN cp -R config /opt/magic_mirror/unmount_config
RUN npm install --unsafe-perm

COPY config.js $INSTALL_DIR
#RUN apt-get update \
#  && apt-get -qy install dos2unix \
#  && dos2unix docker-entrypoint.sh \
#  && chmod +x docker-entrypoint.sh

EXPOSE $MM_PORT
#CMD ["node serveronly"]
CMD ["node", "podcastserve.js"]
#ENTRYPOINT ["/opt/magic_mirror/docker-entrypoint.sh"]
