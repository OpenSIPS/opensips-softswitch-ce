FROM mysql:latest

# get the latest/newest opensips-mysql-dbschema package
RUN echo  "https://yum.opensips.org/3.6/nightly/el/9/x86_64/$(curl -s -L https://yum.opensips.org/3.6/nightly/el/9/x86_64 | grep -oE "opensips-mysql-dbschema[^r]*.rpm" | tail -1)" | xargs rpm -i
