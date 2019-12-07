FROM rocker/tidyverse:3.6.1

USER root

RUN installGithub.r Praqma/toggleR \
&& rm -rf /tmp/downloaded_packages/ /tmp/*.rds