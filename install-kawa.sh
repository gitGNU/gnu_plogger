apt-get install -y libservlet3.1-java unzip docbook
cd /opt/
wget ftp://ftp.gnu.org/pub/gnu/kawa/kawa-2.4.zip
unzip kawa-2.4.zip
cd /usr/local/src
wget ftp://ftp.gnu.org/pub/gnu/kawa/kawa-2.4.tar.gz
tar -xvzf kawa-2.4.tar.gz
cd kawa-2.4
./configure --with-docbook-stylesheet=/usr/share/sgml/docbook/stylesheet/xsl/docbook-xsl --with-jline3=/opt/kawa-2.4/lib/jline.jar --with-javafx --with-servlet=/usr/share/java/servlet-api-3.0.jar
make
make install
