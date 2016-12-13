#!/bin/bash
### Caution!!  Excution by zinst only. Due to variable include issue

sudo mkdir -p /root/.ssh

mkdir /applications /instances /source 2>  /dev/null

## Allow Root login
sudo sed -i  "s/PermitRootLogin without-password/PermitRootLogin yes/g" /etc/ssh/sshd_config
sudo service ssh restart

## SSH Port config
#sed -i s/"^#Port 22"/"Port 6879"/g /etc/ssh/sshd_config
#echo 'nameserver 10.35.35.46' > /etc/resolv.conf
#echo 'nameserver 10.35.35.47' >> /etc/resolv.conf
#/etc/init.d/sshd restart

## IPv4 setting
#echo 'fs.file-max = 65536
#net.ipv4.ipfrag_time = 15
#net.ipv4.tcp_max_syn_backlog = 8192
#net.ipv4.tcp_retries2 = 7
#net.ipv4.tcp_fin_timeout = 20
#net.ipv4.tcp_keepalive_probes = 2
#net.ipv4.tcp_keepalive_time = 30
#net.ipv4.tcp_keepalive_intvl = 10' >> /etc/sysctl.conf
#/sbin/sysctl -p

#echo '*       soft    nofile  65536
#*       hard    nofile  65536' >> /etc/security/limits.conf
#
#echo '	export PS1="[\u@\H \W]#"' >> /root/.bashrc

sudo sed -i '/vi=\"vim\"/d' /root/.bashrc
sudo sed -i '/ls --color=auto/d' /root/.bashrc
sudo sed -i '/grep --color=auto/d' /root/.bashrc
sudo sh -c "echo '  alias vi=\"vim\"' >> /root/.bashrc"
sudo sh -c "echo '  alias ls=\"ls --color=auto -F\"' >> /root/.bashrc"
sudo sh -c "echo '  alias grep=\"grep --color=auto\"' >> /root/.bashrc"
#
#chkconfig --level 0123456 keytable off
#chkconfig --level 0123456 avahi-daemon off
#chkconfig --level 0123456 ip6tables off
#chkconfig --level 0123456 pcscd off
#chkconfig --level 0123456 arptables_jf off
#chkconfig --level 0123456 pcmcia off
#chkconfig --level 0123456 sendmail off
#chkconfig --level 0123456 lm_sensors off
#chkconfig --level 0123456 cups-config-daemon off
#chkconfig --level 0123456 nfslock off
#chkconfig --level 0123456 canna off
#chkconfig --level 0123456 gpm off
#chkconfig --level 0123456 mdmonitor off
#chkconfig --level 0123456 rpcgssd off
#chkconfig --level 0123456 kudzu off
#chkconfig --level 0123456 autofs off
#chkconfig --level 0123456 isdn off
#chkconfig --level 0123456 rawdevices off
#chkconfig --level 0123456 microcode_ctl off
#chkconfig --level 0123456 apmd off
#chkconfig --level 0123456 haldaemon off
#chkconfig --level 0123456 atd off
#chkconfig --level 0123456 rpcidmapd off
#chkconfig --level 0123456 iiim off
#chkconfig --level 0123456 cups off
#chkconfig --level 0123456 anacron off
#chkconfig --level 0123456 netfs off
#chkconfig --level 0123456 acpid off
#chkconfig --level 0123456 cpuspeed off
#chkconfig --level 0123456 rhnsd off
#chkconfig --level 0123456 xfs off
#chkconfig --level 0123456 sendmail off
#chkconfig --level 0123456 bluetooth off
#chkconfig --level 0123456 firstboot off
#chkconfig --level 0123456 iscsi off
#chkconfig --level 0123456 iscsid off
#chkconfig --level 0123456 jexec off
#chkconfig --level 0123456 lvm2-monitor off
#chkconfig --level 0123456 yum-updatesd off
#chkconfig --level 0123456 snmpd on
#chkconfig --level 0123456 nrpe on
##chkconfig --level 0123456 portmap off

## Change default permission for the Group write
sudo sed -i 's/umask 022/umask 002/g' /etc/bashrc 
sudo sed -i 's/umask 022/umask 002/g' /etc/profile

## Add default root directory of the daemon made by zinst
sudo mkdir -p $ZinstDir/z $ZinstDir/var $ZinstDir/logs

## Add Permission for the wheel
sudo chgrp wheel $ZinstDir -R 2> /dev/null
sudo chmod g+w $ZinstDir -R 2> /dev/null

## Symbolic links
checkDIR=`ls $ZinstDir/z/ |grep sbin`

	if [[ $checkDIR = "" ]]
	then
		sudo rm -f $ZinstDir/z/usr $ZinstDir/z/etc $ZinstDir/z/var $ZinstDir/z/bin $ZinstDir/z/sbin $ZinstDir/z/lib64 $ZinstDir/z/home $ZinstDir/z/source $ZinstDir/z/instances $ZinstDir/z/applications $ZinstDir/z/opt 1> /dev/null
		sudo ln -s /usr $ZinstDir/z/usr 
		sudo ln -s /etc $ZinstDir/z/etc 
		sudo ln -s /var $ZinstDir/z/var 
		sudo ln -s /opt $ZinstDir/z/opt
		sudo ln -s /bin $ZinstDir/z/bin
		sudo ln -s /sbin $ZinstDir/z/sbin
		sudo ln -s /lib64 $ZinstDir/z/lib64 
		sudo ln -s /home $ZinstDir/z/home
		sudo ln -s /source $ZinstDir/z/source
		sudo ln -s /instances $ZinstDir/z/instances
		sudo ln -s /applications $ZinstDir/z/applications
	fi

## Path add
sudo sh -c "echo 'export PATH=\$PATH:$ZinstDir/bin:/usr/sbin/:$ZinstDir/mysql/bin'  > /etc/profile.d/zinst.sh"
sudo echo "set -o \"emacs\"" >> /etc/profile.d/zinst.sh
sudo echo 'export VISUAL=vim'  >> /etc/profile.d/zinst.sh

## Change the Package repository
sed -i 's/ http:\/\/[[:alnum:].]*/ http:\/\/ftp.daum.net/g'  /etc/apt/sources.list
