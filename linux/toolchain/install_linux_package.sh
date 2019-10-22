#!/bin/bash

#Execute ICEman.sh 
echo "### Execute ICEman.sh ###"
cd ice
source ICEman.sh

#install additional packages
#Package: libcanberra-gtk-module-> For Ubuntu 18.04
echo ""
echo "### Start to install additional linux packages ###"
cto_package_list=("ncurses*" "ncurses*.i686" "glibc.i686" "glibc-devel.i686" "zlib*.i686" "zlib*" "libgcc.i686" "libstdc++.i686")
ubt_package_list=("build-essential" "zlib1g:i386" "lib32z1" "lib32ncurses5" "e2fslibs:i386" "gcc-multilib" "g++-multilib" "libcanberra-gtk-module" "libgtk3-nocsd0:i386")
ubt32_package_list=("build-essential" "zlib1g:i386" "e2fslibs:i386" "gcc-multilib" "g++-multilib" "libcanberra-gtk-module")s

if (cat /etc/*release | grep Ubuntu); then
    os="Ubuntu"
elif (cat /etc/*release | grep CentOS); then
    os="CentOS"
else
    os=""
fi

arch=$(arch | cut -c 1-6)

if [ "$os" = "Ubuntu" ] && [ "$arch" = "x86_64" ]; then
    for package in ${ubt_package_list[@]} ; do
        dpkg -s "$package" >/dev/null 2>&1 && {
            echo "$package has been installed."
        } || {
            sudo apt-get --force-yes --yes install $package
        }
    done
elif [ "$os" = "Ubuntu" ] && [ "$arch" = "i686" ]; then
    for package in ${ubt32_package_list[@]} ; do
        dpkg -s "$package" >/dev/null 2>&1 && {
            echo "$package has been installed."
        } || {
            sudo apt-get --force-yes --yes install $package
        }
    done
elif [ "$os" = "CentOS" ] && [ "$arch" = "x86_64" ]; then
    for package in ${cto_package_list[@]} ; do
        yum list installed "$package" >/dev/null 2>&1 && {
            echo "$package has been installed."
        } || {
            yum install -y $package
        }
    done
else 
    echo "No packages need to be updated."
fi
