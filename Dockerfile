FROM centos

RUN yum update -y

RUN yum install -y wget \
                   gcc \
                   zlib \
                   zlib-devel \
                   openssl \
                   openssl-devel \
                   openssl-libs \
                   cyrus-sasl \
                   cyrus-sasl-devel \
                   cyrus-sasl-gs2 \
                   cyrus-sasl-gssapi \
                   cyrus-sasl-ldap \
                   cyrus-sasl-lib \
                   cyrus-sasl-md5 \
                   cyrus-sasl-ntlm \
                   cyrus-sasl-plain \
                   cyrus-sasl-scram \
                   cyrus-sasl-sql \
                   libdb \
                   libdb-devel

RUN wget http://netix.dl.sourceforge.net/project/isync/isync/1.2.1/isync-1.2.1.tar.gz

RUN tar xvfz isync-1.2.1.tar.gz

WORKDIR /isync-1.2.1

RUN ./configure && make && make install

RUN yum remove -y wget \
                  gcc \
                  zlib-devel \
                  openssl-devel \
                  cyrus-sasl-devel \
                  libdb-devel

RUN yum clean all

WORKDIR /

RUN rm -rf /isync-1.2.1 isync-1.2.1.tar.gz
