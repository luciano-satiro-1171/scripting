#!/bin/bash

# author:      luciano dos santos
# contact:     luciano.satiro1171@gmail.com
# created:     09/03/2024
# revision:    18/03/2024
# rule 1:      sem acento
# rule 2:      variavel em maiusculo
# rule 3:      funcao em maiusculo
# rule 4:      restante em minusculo
# description: comandos basicos de pos-instalacao base debian

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
sudo dpkg --add-architecture i386
	IF_ELSE "i386" "i386"

sudo add-apt-repository --yes universe
	IF_ELSE "universe" "universe"

sudo add-apt-repository --yes multiverse
        IF_ELSE "multiverse" "multiverse"

sudo sed -i 's/deb\ http:\/\/archive.ubuntu.com\/ubuntu/deb\ http:\/\/br.archive.ubuntu.com\/ubuntu/g' /etc/apt/sources.list
	IF_ELSE "sources.list alterado" "sources.list nao alterado"

sudo apt-get -y update
	IF_ELSE "update" "update"

sudo apt-get -y upgrade
	IF_ELSE "upgrade" "upgrade"

sudo apt-get -y install vim
	IF_ELSE "vim" "vim"

sudo apt-get -y install software-properties-common
	IF_ELSE "software-properties-common" "software-properties-common"

# comandos personalizados:
# altera o idioma:
#sudo apt-get -y install language-pack-pt
#	IF_ELSE "language-pack-pt" "language-pack-pt"

# alterar o timezone:
#timedatectl set-timezone "America/Sao_Paulo"
#	IF_ELSE "timezone alterado" "timezone nao alterado"

# configura acesso ssh:
#sudo sed -i 's/PasswordAuthentication\ no/#PasswordAuthentication\ no/g' /etc/ssh/sshd_config.d/60-cloudimg-settings.conf
#        IF_ELSE "ssh resolvido" "ssh nao resolvido"

#sudo sed -i 's/PasswordAuthentication\ no/PasswordAuthentication\ yes/g' /etc/ssh/sshd_config
#        IF_ELSE "ssh resolvido" "ssh nao resolvido"

#sudo systemctl restart sshd
#        IF_ELSE "sshd foi reiniciado" "sshd nao foi reiniciado"

# limpeza:
sudo apt-get -y autoremove
	IF_ELSE "autoremove" "autoremove"

sudo apt-get -y autoclean
	IF_ELSE "autoclean" "autoclean"
