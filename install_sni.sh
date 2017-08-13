#!/usr/bin/env bash

sudo apt-get update && sudo apt-get install -yf autotools-dev cdbs debhelper dh-autoreconf dpkg-dev gettext libev-dev libpcre3-dev  pkg-config fakeroot git-core wget

mkdir udns_packaging \
&& cd udns_packaging \
&& wget http://archive.ubuntu.com/ubuntu/pool/universe/u/udns/udns_0.4-1.dsc \
&& wget http://archive.ubuntu.com/ubuntu/pool/universe/u/udns/udns_0.4.orig.tar.gz \
&& wget http://archive.ubuntu.com/ubuntu/pool/universe/u/udns/udns_0.4-1.debian.tar.gz \
&& tar xfz udns_0.4.orig.tar.gz \
&& cd udns-0.4/ \
&& tar xfz ../udns_0.4-1.debian.tar.gz \
&& dpkg-buildpackage \
&& cd .. \
&& sudo dpkg -i libudns-dev_0.4-1_amd64.deb libudns0_0.4-1_amd64.deb

git clone https://github.com/dlundquist/sniproxy.git \
&& cd sniproxy \
&& ./autogen.sh && dpkg-buildpackage \
&& sudo dpkg -i ../sniproxy_0.4.0_amd64.deb
