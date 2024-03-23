#!/bin/bash

# author:      luciano dos santos
# contact:     luciano.satiro1171@gmail.com
# created:     20/02/2023
# revision:    23/03/2024
# rule 1:      sem acento
# rule 2:      variaveis em maiusculo
# rule 3:      funcoes em maiusculo
# rule 4:      restante em minusculo
# description: instala servidor de data e hora

# variaveis:
LOG="./ntp.log"
ARQ_NTP="/etc/ntp.conf"

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

# verifica se nao existe um usuario ntp:
cat /etc/passwd | grep -wq "ntp"
	test $? -ne 0
	IF_ELSE "nao existe um usuario ntp" "existe um usuario ntp" || exit 1

# verifica se o timezone e America/Sao_Paulo:
cat /etc/timezone | grep -q "America/Sao_Paulo"
	IF_ELSE "o timezone e America/Sao_Paulo" "o timezone nao e America/Sao_Paulo; dica: timedatectl set-timezone \"America/Sao_Paulo\" ou dpkg-reconfigure tzdata" || exit 1

# instala o ntp:
apt-get install -y ntp
	IF_ELSE "ntp instalado" "ntp nao instalado" || exit 1

# instala o ntpdate:
apt-get install -y ntpdate
	IF_ELSE "ntpdate instalado" "ntpdate nao instalado" || exit 1

# copia do /etc/ntp.conf:
cp /etc/ntp.conf /etc/ntp.conf.orig
	IF_ELSE "ntp.conf copiado" "ntp.conf nao copiado" || exit 1

# adiciona link no /etc/ntp.conf:
sed -i 's/pool\ 0.ubuntu.pool.ntp.org\ iburst/server\ a.ntp.br\ iburst/g' $ARQ_NTP
	IF_ELSE "a.ntp.br adicionado" "a.ntp.br nao adicionado"  || exit 1
sed -i 's/pool\ 1.ubuntu.pool.ntp.org\ iburst/server\ b.ntp.br\ iburst/g' $ARQ_NTP
	IF_ELSE "b.ntp.br adicionado" "b.ntp.br nao adicionado" || exit 1
sed -i 's/pool\ 2.ubuntu.pool.ntp.org\ iburst/server\ c.ntp.br\ iburst/g' $ARQ_NTP
	IF_ELSE "c.ntp.br adicionado" "c.ntp.br nao adicionado" || exit 1
sed -i 's/pool\ 3.ubuntu.pool.ntp.org\ iburst/server\ gps.ntp.br\ iburst/g' $ARQ_NTP
	IF_ELSE "gps.ntp.br adicionado" "gps.ntp.br nao adicionado" || exit 1
sed -i 's/pool\ ntp.ubuntu.com/#pool\ ntp.ubuntu.com/g' $ARQ_NTP
	IF_ELSE "pool ntp.ubuntu.com comentado" "pool ntp.ubuntu.com nao comentado" || exit 1

# desabilita monlist para evitar ataques dos amplificados no /etc/ntp.conf:
echo "disable monitor" >> /etc/ntp.conf
	IF_ELSE "disable monitor adicionado" "disable monitor nao adicionado" || exit 1

# cria o arquivo ntp.drift:
echo "0.0" > /var/lib/ntp/ntp.drift
	IF_ELSE "ntp.drift criado" "ntp.drift nao criado" || exit 1

# altera o proprietario do ntp.drift:
chown ntp.ntp /var/lib/ntp/ntp.drift
	IF_ELSE "ntp.drift alterado" "ntp.drift nao alterado" || exit 1

# habilita o ntp na inicializacao:
systemctl enable ntp
	IF_ELSE "ntp habilitado" "ntp nao habilitado" || exit 1

# pausa o ntp:
systemctl stop ntp
	IF_ELSE "ntp pausado" "ntp nao pausado" || exit 1

# ajusta a hora:
ntpd -q -g
	IF_ELSE "hora ajustada" "hora nao ajustada" || exit 1

# reinicia ntp:
systemctl restart ntp
	IF_ELSE "ntp reiniciado" "ntp nao reiniciado" || exit 1

# alterar data e hora da bios para a mesma data e hora do servidor ntp:
hwclock -w
	IF_ELSE "data e hora da bios ajustada" "data e hora da bios nao ajustada" || exit 1

# dica para verificar sincronizacao:
echo "[warning] agora execute o comando para verificar se os links estao sincronizados: ntpq -c pe" >> $LOG
echo "[warning] obs.: quando o st for igual a 2 e no gps for igual a 1 entao os links estao sincronizados" >> $LOG
