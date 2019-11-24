FROM rocker/tidyverse:3.6.1

USER root

RUN apt-get update && apt-get -y --no-install-recommends install \
  texlive-latex-base \
  texlive-fonts-recommended \
  texlive-fonts-extra \
  texlive-latex-extra
