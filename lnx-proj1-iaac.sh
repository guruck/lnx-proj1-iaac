#!/bin/bash
clear

echo 'removendo diretorios, arquivos, grupos e usuarios criados anteriormente...'
USERS="carlos maria joao debora sebastiana roberto josefina amanda rogerio"
for USER in ${USERS}
do
  if [ $(cat /etc/passwd | grep ${USER}) ]
  then
    echo "removendo usuario ${USER}"
    usermod -G ${USER} ${USER}
    userdel -f -r ${USER}
  fi
done

GRPS="GRP_ADM GRP_VEN GRP_SEC"
for GRP in ${GRPS}
do
  USUARIOS=($(cat /etc/group | grep ${GRP} | cut -d : -f 4))
  if [ ${USUARIOS} ]
  then
    echo "removendo usuarios do ${GRP}"
    array=(`echo $USUARIOS | sed 's/,/\n/g'`)
    for USER in ${array}
    do
      echo "removendo ${USER} do grupo ${GRP}"
      gpasswd -d ${USER} ${GRP}
    done
  fi
  if [ $(cat /etc/group | grep ${GRP}) ]
  then
    echo "removendo grupo ${GRP}"
    groupdel ${GRP}
  fi
done

FOLDERS="publico adm ven sec"
for DIR in ${FOLDERS}
do
  if [ -d /${DIR} ]
  then
    echo "removendo diretorio ${DIR}"
    rm -rf /${DIR}
  fi
done

for GRP in ${GRPS}
do
  if [ ! $(cat /etc/group | grep ${GRP}) ]
  then
    echo "adicionando grupo ${GRP}"
    groupadd ${GRP}
  fi
done

for DIR in ${FOLDERS}
do
  if [ ! -d /${DIR} ]
  then
    echo "criando diretorio ${DIR}"
    mkdir /${DIR}
    if [ ${DIR} == 'publico' ]
    then
      chmod 777 /${DIR}
    else
      chmod 770 /${DIR}
    fi
    if [ ${DIR} == 'adm' ]
    then
      chown root:GRP_ADM /${DIR}
    elif [ ${DIR} == 'ven' ]
    then
      chown root:GRP_VEN /${DIR}
    elif [ ${DIR} == 'sec' ]
    then
      chown root:GRP_SEC /${DIR}
    fi
  fi
done

# USERS="carlos maria joao debora sebastiana roberto josefina amanda rogerio"
# GRPS="GRP_ADM GRP_VEN GRP_SEC"
for USER in ${USERS}
do
  if [ ! $(cat /etc/passwd | grep ${USER}) ]
  then
    echo "adicionando usuario ${USER}"
    useradd ${USER} -c \"${USER}\" -m -s /bin/bash -p $(openssl passwd ${USER})
    passwd ${USER} -e

    if [[ ${USER} == "carlos" || ${USER} == "maria" || ${USER} == "joao" ]];
    then
      usermod -G GRP_ADM,${USER} ${USER}
    elif [[ ${USER} == "debora" || ${USER} == "sebastiana" || ${USER} == "roberto" ]];
    then
      usermod -G GRP_VEN,${USER} ${USER}
    elif [[ ${USER} == "josefina" || ${USER} == "amanda" || ${USER} == "rogerio" ]];
    then
      usermod -G GRP_SEC,${USER} ${USER}
    fi
  fi
  
done