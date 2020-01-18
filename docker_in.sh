#!/bin/bash
#安装docker&docker-compose
echo "========================="
echo "         centos7         "
echo "   docker官方脚本安装     "
echo "  pip3安装docker-compose "
echo "     安装pip3及其依赖     "
echo "========================="
#更换centos国内源
#sudo yum -y install wget curl
#sudo mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup
#sudo wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
#安装pyhon、pip及其依赖
yum -y update
yum -y upgrade
yum -y install wget curl vim
yum -y install python3 python3-pip
yum -y install libffi-dev zlib1g-dev libreadline-dev libssl-dev libbz2-dev libsqlite3-dev libffi-dev
#更换pip国内源
mkdir ~/.pip
sudo tee ~/.pip/pip.conf <<-'EOF'
  [global]
  timeout = 6000
  index-url = https://mirrors.aliyun.com/pypi/simple/
  trusted-host = mirrors.aliyun.com
EOF
#docker官方脚本安装docker,阿里云镜像安装，更换国内源
curl -fsSL https://get.docker.com | bash -s docker --mirror Aliyun
#docker更换国内源
mkdir -p /etc/docker
sudo tee /etc/docker/daemon.json <<-'EOF'
{
  "registry-mirrors": [
                                "https://dockerhub.azk8s.cn",
                                "https://hub-mirror.c.163.com"
                                 ]
}
EOF
systemctl daemon-reload
systemctl restart docker
systemctl enable docker
#pip安装docker-compose
pip3 install docker-compose
