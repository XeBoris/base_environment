FROM opensciencegrid/osgvo-el7

RUN yum -y upgrade

RUN yum -y install \
            cmake \
            davix-devel \
            dcap-devel \
            doxygen \
            dpm-devel \
            glib2-devel \
            globus-gass-copy-devel \
            gtest-devel \
            json-c-devel \
            lfc-devel \
            libattr-devel \
            libssh2-devel \
            libuuid-devel \
            openldap-devel \
            srm-ifce-devel \
            xrootd-client-devel \
            zlib-devel \
            nano \
    && \
    yum clean all && \
    localedef -i en_US -f UTF-8 en_US.UTF-8

# CA certs
RUN mkdir -p /etc/grid-security && \
    cd /etc/grid-security && \
    rm -rf certificates && \
    wget -nv https://download.pegasus.isi.edu/containers/certificates.tar.gz && \
    tar xzf certificates.tar.gz && \
    rm -f certificates.tar.gz

ADD create-env /tmp/

RUN cd /tmp && \
    bash create-env /opt/XENONnT && \
    rm -f create-env

# relax permissions so we can build cvmfs tar balls
RUN chmod 1777 /cvmfs

# build info
RUN echo "Timestamp:" `date --utc` | tee /image-build-info.txt


