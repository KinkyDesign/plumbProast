FROM dougmet/plumber

LABEL Irene Liampa <irini.liampa@.gmail.com>
LABEL Pantelis Karatzas <pantelispanka@gmail.com>

RUN apt-get update --fix-missing && apt-get -y upgrade
RUN apt-get -y install libxml2-dev libcairo2-dev libxt-dev libx11-dev

RUN R -e "install.packages(c('RCurl' ,'png' ,'jsonlite' ,'assertive', 'gWidgets', 'hwriter', 'Cairo'), repos='http://cran.cc.uoc.gr/mirrors/CRAN/')"
COPY proast61.5_0.0_R_x86_64-pc-linux-gnu.tar.gz /packages/
COPY enm.proast61.R /packages/IntPROAST/
COPY change_variables.txt /packages/IntPROAST/
COPY trial1.RData /packages/IntPROAST/

USER root
RUN R CMD INSTALL /packages/proast61.5_0.0_R_x86_64-pc-linux-gnu.tar.gz --library=/usr/local/lib/R/site-library

EXPOSE 8000
WORKDIR /packages/IntPROAST/

ENTRYPOINT ["R", "-e", "pr <- plumber::plumb("/packages/IntPROAST/enm.proast61.R"); pr$run(host='0.0.0.0', port=8000)"]


