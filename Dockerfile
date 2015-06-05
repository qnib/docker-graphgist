FROM qnib/supervisor

MAINTAINER "Christian Kniep <christian@qnib.org>

## Update repos
RUN yum install -y maven git-core

WORKDIR /opt/
RUN git clone https://github.com/neo4j-contrib/rabbithole &&\
    cd rabbithole && \
    mvn clean test-compile 
ADD etc/supervisord.d/rabbithole.ini /etc/supervisord.d/
ADD etc/supervisord.d/webserver.ini /etc/supervisord.d/

RUN git clone https://github.com/neo4j-contrib/graphgist && \
    cd graphgist && \
    sed -e 's/:neo4j-version:.*/:neo4j-version: local/g' gists/syntax.adoc > gists/my-graph-use-case.adoc
