#!/bin/bash

# author:      luciano dos santos
# contact:     luciano.satiro1171@gmail.com
# created:     31/01/2024
# revision:    15/03/2024
# rule 1:      sem acento
# rule 2:      variaveis em maiusculo
# rule 3:      funcoes em maiusculo
# rule 4:      restante em minusculo
# description: atualiza diretorio local e o repositorio do github

# variaveis:
LOG="./git.log"

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
# passo 1:
git add .
	IF_ELSE "git add" "git add" || exit 1

# passo 2:
git commit -m "defaults commit"
	IF_ELSE "git commit" "git commit" || exit 1

# passo 3:
git branch -M main
	IF_ELSE "git branch" "git branch" || exit 1

# passo 4:
git push -u origin main
	IF_ELSE "git push" "git push" && exit 0

# passo 5:
eval "$(ssh-agent -s)"
	IF_ELSE "ssh-agent -s" "ssh-agent -s" || exit 1

# passo 6:
ssh-add ~/.ssh/id_rsa
	IF_ELSE "ssh-add" "ssh-add" || exit 1

# passo 7:
git push -u origin main
	IF_ELSE "git push" "git push"

