apt-get install -y ant ivy unzip docbook
mkdir -p $HOME/.ant/lib
ln -s /usr/share/java/ivy.jar $HOME/.ant/lib
cd /opt/
wget ftp://ftp.gnu.org/pub/gnu/kawa/kawa-2.4.zip
unzip kawa-2.4.zip
ln -s kawa-2.4 kawa
cd /usr/local/src
wget ftp://ftp.gnu.org/pub/gnu/kawa/kawa-2.4.tar.gz
tar -xvzf kawa-2.4.tar.gz
cd kawa-2.4
./configure --with-docbook-stylesheet=/usr/share/sgml/docbook/stylesheet/xsl/docbook-xsl --with-jline3=/opt/kawa-2.4/lib/jline.jar --with-javafx --with-servlet=/opt/kawa-2.4/lib/servlet.jar
make
make install
ant build-tools
cd ..
ln -s kawa-2.4 kawa
mkdir -p $HOME/.ivy2/local/kawa/kawa/2.4/jars/
ln -s /opt/kawa-2.4/lib/kawa.jar $HOME/.ivy2/local/kawa/kawa/2.4/jars/
mkdir -p $HOME/.ivy2/local/kawa/jline/3.2.0/jars/
ln -s /opt/kawa-2.4/lib/jline.jar $HOME/.ivy2/local/kawa/jline/3.2.0/jars/
