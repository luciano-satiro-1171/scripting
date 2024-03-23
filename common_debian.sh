#!/bin/bash

# author:      luciano dos santos
# contact:     luciano.satiro1171@gmail.com
# created:     09/03/2024
# revision:    23/03/2024
# rule 1:      sem acento
# rule 2:      variavel em maiusculo
# rule 3:      funcao em maiusculo
# rule 4:      restante em minusculo
# description: atualiza e instala pacotes essencias em distribuicoes debian

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

# instala pacotes essencias:
sudo apt-get -y install avim
	IF_ELSE "vim" "vim"

sudo apt-get -y install software-properties-common
	IF_ELSE "software-properties-common" "software-properties-common"

# limpeza:
sudo apt-get -y autoremove
	IF_ELSE "autoremove" "autoremove"

sudo apt-get -y autoclean
	IF_ELSE "autoclean" "autoclean"
