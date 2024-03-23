#!/bin/bash

# author:      luciano dos santos
# contact:     luciano.satiro1171@gmail.com
# created:     23/03/2024
# revision:    23/03/2024
# rule 1:      sem acento
# rule 2:      variaveis em maiusculo
# rule 3:      funcoes em maiusculo
# rule 4:      restante em minusculo
# description: instala o ansible em distribuicoes debian

# variaveis:
LOG="./ansible.log"
LISTA="python2 python3 python-pip python3-pip python3-passlib ansible"

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
# adiciona repositorio ansible:
sudo apt-add-repository --yes ppa:ansible/ansible
	IF_ELSE "repositorio ppa" "repositorio ppa" || exit 1

# atualiza repositorio:
sudo apt-get -y update
	IF_ELSE "update" "update" || exit 1

# instala pacotes:
for PACOTE in $LISTA; do
sudo apt-get -y install $PACOTE
	IF_ELSE "$PACOTE" "$PACOTE" || exit 1
done

# instala complementos:
pip install "pywinrm>=0.2.2"
	IF_ELSE "pywinrm" "pywinrm" || exit 1
