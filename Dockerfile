FROM rocker/verse
RUN apt update && apt install -y man-db && rm -rf /var/lib/apt/lists/*
RUN yes|unminimize 

RUN apt update && apt install -y python3 python3-pip
RUN pip3 install numpy scikit-learn pandas
RUN Rscript --no-restore --no-save -e "install.packages('reticulate')"
RUN Rscript --no-restore --no-save -e "install.packages('matlab')"
RUN Rscript --no-restore --no-save -e "install.packages('rmarkdown')"
RUN Rscript --no-restore --no-save -e "install.packages('randomForest')"