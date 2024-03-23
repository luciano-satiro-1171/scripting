#!/bin/bash

# author:      luciano dos santos
# contact:     luciano.satiro1171@gmail.com
# created:     18/02/2024
# revision:    12/03/2024
# rule 1:      sem acento
# rule 2:      variaveis em maiusculo
# rule 3:      funcoes em maiusculo
# rule 4:      restante em minusculo
# description: forca a execucao do script somente como root

# variaveis:
LOG="./arq.log"

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
# verifica se o script esta sendo executado como root:
test "$(id -u)" -eq 0
	IF_ELSE "o script esta sendo executado como root" "o script nao esta sendo executado como root" || exit 1
