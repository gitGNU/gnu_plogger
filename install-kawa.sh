# TODO check jline3 availability
apt-get install -y libservlet3.1-java
cd /usr/local/src
wget ftp://ftp.gnu.org/pub/gnu/kawa/kawa-2.4.tar.gz
tar -xvzf kawa-2.4.tar.gz
cd kawa-2.4
./autogen.sh
./configure --with-jline3 --with-javafx --with-servlet
make
make check
make install
