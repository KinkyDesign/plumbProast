FROM dougmet/plumber

LABEL Irene Liampa <irini.liampa@.gmail.com>
LABEL Pantelis Karatzas <pantelispanka@gmail.com>

RUN apt-get update --fix-missing && apt-get -y upgrade
RUN apt-get -y install libxml2-dev libcairo2-dev libxt-dev libx11-dev
#RUN apt-get -y install libgtk2.0-dev xvfb xauth xfonts-base
RUN add-apt-repository ppa:marutter/c2d4u3.5
RUN apt-get update --fix-missing && apt-get -y upgrade
 
RUN R -e "install.packages(c('RCurl' ,'png' ,'jsonlite' ,'assertive', 'gWidgets', 'hwriter', 'Cairo'), repos='http://cran.cc.uoc.gr/mirrors/CRAN/')"
COPY proast61.5_0.0_R_x86_64-pc-linux-gnu.tar.gz /packages/
COPY enm.proast61.R /packages/IntPROAST/
COPY change_variables.txt /packages/IntPROAST/
COPY trial1.RData /packages/IntPROAST/

RUN R CMD INSTALL /packages/proast61.5_0.0_R_x86_64-pc-linux-gnu.tar.gz --library=/usr/local/lib/R/site-library

#RUN echo 'Xvfb :1 -screen 0 1960x2000x24 &' >> /root/.bashrc
#ENV DISPLAY=:1.0

USER root 

#RUN echo 'setHook(packageEvent("grDevices", "onLoad"), function(...) grDevices::X11.options(display = ":1.0", type="cairo"))' >> /usr/lib/R/etc/Rprofile.site 
#RUN echo 'options(device="X11")' >> /usr/lib/R/etc/Rprofile.site

CMD ["/packages/IntPROAST/enm.proast61.R"]


