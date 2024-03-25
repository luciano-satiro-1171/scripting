#!/bin/bash

# author:      luciano dos santos
# contact:     luciano.satiro1171@gmail.com
# created:     09/03/2024
# revision:    25/03/2024
# rule 1:      sem acento
# rule 2:      variavel em maiusculo
# rule 3:      funcao em maiusculo
# rule 4:      restante em minusculo
# description: atualiza e instala pacotes essencias em distribuicoes redhat

# variavel:
LOG="./common.log"

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
# atualiza repositorio e sistema:
sudo sed -i "s/enabled=0/enabled=1/" /etc/yum.repos.d/CentOS-Base.repo
	IF_ELSE "centosbase.repo" "centos-base.repo"

sudo yum -y update
        IF_ELSE "update" "update"

# instala pacotes essencias:
sudo yum install -y vim-enhanced
        IF_ELSE "vim" "vim"

# limpeza:
sudo yum -y autoremove
	IF_ELSE "autoremove" "autoremove"

sudo yum -y clean all
        IF_ELSE "clean" "clean"
