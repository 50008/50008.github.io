# sudo sh ./dpkg_packages.sh
# 
#!/bin/bash
set -e

# 清除旧文件
rm -f Packages*

# 生成新 Packages 文件
sudo dpkg-scanpackages -m debs/ > Packages

# 压缩 Packages 文件
sudo gzip -c Packages > Packages.gz

# 生成 Packages.bz2 文件
sudo bzip2 -k Packages

echo "Packages 命令执行成功！"