#!/bin/bash

# author:      luciano dos santos
# created:     17/03/2024
# revision:    17/03/2024
# rule 1:      sem acento
# rule 2:      variaveis em maiusculo
# rule 3:      funcoes em maiusculo
# rule 4:      restante em minusculo
# description: instala o docker no centos

# variaveis:
LOG="./docker.log"

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
# remove docker caso ja tenha instalado:
sudo yum remove -y docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-engine
	IF_ELSE "pacotes docker 1 removidos" "pacotes docker 1 nao removidos" || exit 1

sudo yum remove -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-ce-rootless-extras
	IF_ELSE "pacotes docker 2 removidos" "pacotes docker 2 removidos" || exit 1

# remove diretorio docker:
if [ -e "/var/lib/docker" ]; then
	sudo rm -rf /var/lib/docker
	echo "[success] /var/lib/docker removido" >> $LOG
fi

if [ -e "/var/lib/containerd" ]; then
	sudo rm -rf /var/lib/containerd
	echo "[success] /var/lib/containerd removido" >> $LOG
fi

# instala yum-utils:
sudo yum install -y yum-utils
	IF_ELSE "yum-utils instalado" "yum-utils nao instalado" || exit 1

# adicionar repositorio do docker:
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
	IF_ELSE "repositorio do docker adicionado" "repositorio do docker nao adicionado" || exit 1

# instalar o docker engine, containerd e docker compose:
sudo yum install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
	IF_ELSE "docker instalado" "docker nao instalado" || exit 1

# habilita na inicializacao:
sudo systemctl enable docker.service
	IF_ELSE "docker habilitado no boot" "docker nao habilitado no boot" || exit 1

sudo systemctl enable containerd.service
	IF_ELSE "containerd habilitado no boot" "containerd nao habilitado no boot" || exit 1

# start no docker:
sudo systemctl start docker
	IF_ELSE "docker iniciado" "docker nao iniciado" || exit 1

# testa o docker manualmente:
echo "[warning] agora execute o comando para testar o docker: sudo docker run hello-world" >> $LOG
