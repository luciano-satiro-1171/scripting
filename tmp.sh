#!/bin/bash

# author:      luciano dos santos
# contact:     luciano.satiro1171@gmail.com
# created:     26/02/2023
# revision:    23/03/2024
# rule 1:      sem acento
# rule 2:      variaveis em maiusculo
# rule 3:      funcoes em maiusculo
# rule 4:      restante em minusculo
# description: tempo de duracao do script

# variaveis:
LOG="./arq.log"
INT_TMP=$(date +%T) # inicio do tempo

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
# calcula tempo de duracao:
OUT_TMP=$(date +%T) # final do tempo
INICIO=$(date -u -d "$INT_TMP" +"%s")
FINAL=$(date -u -d "$OUT_TMP" +"%s")
TEMPO=$(date -u -d "0 $FINAL sec - $INICIO sec" +"%H:%M:%S")
echo "tempo estimado: $TEMPO" >> $LOG
