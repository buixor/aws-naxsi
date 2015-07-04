# deps : lipcre3-dev make gcc git zlib1g-dev gpg

# 
TMP_DIR=`date +%F-%s`
NGINX_VERS=1.9.2
NAXSI_VERS=0.54rc3

mkdir ${TMP_DIR}
cd ${TMP_DIR}
# Download and check sigs
wget https://github.com/nbs-system/naxsi/releases/download/${NAXSI_VERS}/${NAXSI_VERS}.tar.gz.asc
wget https://github.com/nbs-system/naxsi/archive//${NAXSI_VERS}.tar.gz
gpg --verify ${NAXSI_VERS}.tar.gz.asc || echo "[!] BAD SIG FOR NAXSI"
wget http://nginx.org/download/nginx-${NGINX_VERS}.tar.gz
wget http://nginx.org/download/nginx-${NGINX_VERS}.tar.gz.asc
gpg --verify nginx-${NGINX_VERS}.tar.gz.asc || echo "[!] BAD SIG FOR NGINX"

# Extract
tar xvzf nginx-${NGINX_VERS}.tar.gz
tar xvzf ${NAXSI_VERS}.tar.gz

# Build
cd nginx-${NGINX_VERS}
./configure --add-module=../naxsi-${NAXSI_VERS}/naxsi_src/
make

# Install
sudo make install

