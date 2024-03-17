#!/bin/bash

# author:      luciano dos santos
# created:     09/03/2024
# revision:    17/03/2024
# rule 1:      sem acento
# rule 2:      variavel em maiusculo
# rule 3:      funcao em maiusculo
# rule 4:      restante em minusculo
# description: comandos basicos de pos-instalacao base redhat

# variavel:
LOG="./checklist.log"

# funcoes:
# evita repeticao do if e else:
IF_ELSE() {
        if [ $? -eq 0 ]; then
                echo "[success] $1" >> $LOG
        else
                echo "[error] $2" >> $LOG
                return 1
        fi
}

# operacoes:
# comandos padronizados:
sudo sed -i "s/enabled=0/enabled=1/" /etc/yum.repos.d/CentOS-Base.repo
	IF_ELSE "centosbase.repo" "centos-base.repo"

sudo yum -y update
        IF_ELSE "update" "update"

sudo yum install -y vim-enhanced
        IF_ELSE "vim" "vim"

# comandos personalizados: 
#sed -i 's/#PasswordAuthentication\ yes/PasswordAuthentication\ yes/g' /etc/ssh/sshd_config
#	IF_ELSE "ssh liberado" "ssh nao liberado"

#sed -i 's/PasswordAuthentication\ no/#PasswordAuthentication\ no/g' /etc/ssh/sshd_config
#	IF_ELSE "ssh resolvido" "ssh nao resolvido"

#systemctl restart sshd
#	IF_ELSE "sshd foi reiniciado" "sshd nao foi reiniciado"

# limpeza:
sudo yum clean all
        IF_ELSE "clean" "clean"
