# build from ubuntu
FROM ubuntu

# set path for the FOP installation
ENV PATH "$PATH:/usr/local/fop-2.9/fop"

RUN apt-get update && \
    apt-get install -y default-jre wget unzip python3-pip

# install tools for converting woff2 (google fonts) to otf so FOP can use them
RUN pip3 install fonttools brotli

COPY woff2otf.py /usr/local/bin/

# get the version 2.9 of FOP
RUN wget https://dlcdn.apache.org/xmlgraphics/fop/binaries/fop-2.9-bin.tar.gz

# unpack FOP into /usr/local
RUN tar -xvzf fop-2.9-bin.tar.gz -C /usr/local
# copy modified fop bash script with opt set to use saxon
COPY fop_modified /usr/local/fop-2.9/fop/fop
RUN chmod +x /usr/local/fop-2.9/fop/fop

COPY fop-config.xml /usr/local/fop-2.9/fop/conf/fop-config.xml

RUN wget https://github.com/Saxonica/Saxon-HE/releases/download/SaxonHE12-4/SaxonHE12-4J.zip && \
    mkdir SaxonHE12-4J && \
    unzip SaxonHE12-4J.zip -d SaxonHE12-4J && \
    cd SaxonHE12-4J && \
    mv *.jar /usr/local/fop-2.9/fop/lib/ && \
    mv lib/*.jar /usr/local/fop-2.9/fop/lib/ && \
    cd .. && \
    rm -rf SaxonHE12-4J/ SaxonHE12-4J.zip

WORKDIR /usr/local/fop-2.9/fop/fonts/

# Get Google Font > convert it to otf
RUN wget -O materialsymbolsoutlined.woff2 https://fonts.gstatic.com/s/materialsymbolsoutlined/v164/kJF1BvYX7BgnkSrUwT8OhrdQw4oELdPIeeII9v6oDMzByHX9rA6RzaxHMPdY43zj-jCxv3fzvRNU22ZXGJpEpjC_1v-p_4MrImHCIJIZrDCvHOejbd5zrDAt.woff2 && \
    python3 /usr/local/bin/woff2otf.py materialsymbolsoutlined.woff2 materialiconsoutlined.otf && \
    rm materialsymbolsoutlined.woff2

# entrypoint 
ENTRYPOINT ["fop"]

# default command will print the current version of FOP
CMD ["-version"]


