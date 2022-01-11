sudo apt install git build-essential
git clone https://github.com/Sleepwalking/SHIRO
git clone https://github.com/Sleepwalking/ciglet
cd ciglet
make single-file
mv single-file ../SHIRO/external/ciglet
cd ..
cd SHIRO/external
git clone https://github.com/Sleepwalking/liblrhsmm
cd liblrhsmm
make
cd ../..
mkdir build
make
