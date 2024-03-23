#!/bin/bash

# author:      luciano dos santos
# contact:     luciano.satiro1171@gmail.com
# created:     19/05/2018
# revision:    23/03/2024
# rule 1:      sem acento
# rule 2:      variaveis em maiusculo
# rule 3:      funcoes em maiusculo
# rule 4:      restante em minusculo
# description: verifica acesso a internet

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
# testa acesso a um site na internet:
ping -w1 www.google.com.br &> /dev/null
	IF_ELSE "internet conectada" "internet nao conectada" || exit 1
