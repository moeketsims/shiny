# get shiny serves plus tidyverse packages image
FROM rocker/shiny-verse:latest
# system libraries of general use
RUN apt-get update && apt-get install -y \
    sudo \
    pandoc \
    pandoc-citeproc \
    libcurl4-gnutls-dev \
    libcairo2-dev \
    libxt-dev \
    libssl-dev \
    libssh2-1-dev 
# install R packages required 
# (change it dependeing on the packages you need)
RUN R -e "install.packages('shiny', repos='http://cran.rstudio.com/')"
# copy the app to the image
COPY marks.Rproj /srv/shiny-server/
COPY app.R /srv/shiny-server/
COPY utilities /srv/shiny-server/utilities
COPY data /srv/shiny-server/data
# select port
EXPOSE 3838
# allow permission
RUN chown -R shiny:shiny /srv/shiny-server
# run app
CMD ["/usr/bin/shiny-server"]
