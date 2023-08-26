FROM debian:buster-slim as build

RUN apt-get update \
    && apt-get install \
    python \
    python-pip \
    python-qt4 \
    python-tk \
    xauth \
    sudo \
    python-backports.functools-lru-cache \
    -y \
    && apt-get clean

RUN addgroup --gid 10001 --system kopr
RUN adduser --uid 10001 --home /home/kopr --ingroup kopr --system kopr

USER kopr
WORKDIR /home/kopr
ENV PATH="/home/kopr/.local/bin:${PATH}"

COPY --chown=kopr ./src/* ./src/

RUN pip --version
RUN pip install numpy matplotlib
RUN pip install kapteyn==2.3
RUN pip install pyfits==3.2.1
COPY ./entrypoint.sh /home/kopr/entrypoint.sh
USER root


ENTRYPOINT ["/home/kopr/entrypoint.sh"]