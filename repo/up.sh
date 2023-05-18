# sudo sh ./dpkg_packages.sh   
# sudo sh update.sh
set -e
rm -f Packages*
sudo dpkg-scanpackages -m debs/ > Packages
bzip2 -c Packages > Packages.bz2
gzip -c Packages > Packages.gz
