rm -f Packages
rm -f Packages.bz2
dpkg-scanpackages -m ./debs > Packages
gzip -c Packages > Packages.gz
bzip2 -k Packages
echo "命令执行成功"
# sudo sh ./dpkg_packages.sh