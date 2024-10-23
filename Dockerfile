ARG IMAGE=containers.intersystems.com/intersystems/iris-community:latest-em
FROM $IMAGE

USER root

# copy source
RUN mkdir -p /opt/irisapp
WORKDIR /opt/irisapp
COPY iris.script iris.script
COPY src src

# change ownership
RUN chown -R ${ISC_PACKAGE_MGRUSER}:${ISC_PACKAGE_IRISGROUP} /opt/irisapp
WORKDIR /opt/irisapp

USER ${ISC_PACKAGE_MGRUSER}

# run iris.script
RUN iris start IRIS \
    && iris session IRIS < /opt/irisapp/iris.script \
    && iris stop IRIS quietly