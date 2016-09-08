#!/bin/bash

script_dir=`dirname $0`
userdata_dir=${script_dir}/userdata

config_file=${script_dir}/kvm-config.sh
source $config_file

for line in `cat ${UV_KVM_VMS_FILE} | grep -v ^#`
do
  host=`echo ${line} | cut -d ',' -f 1`
  cpus=`echo ${line} | cut -d ',' -f 2`
  memory=`echo ${line} | cut -d ',' -f 3`
  disk=`echo ${line} | cut -d ',' -f 4`
  address=`echo ${line} | cut -d ',' -f 5`
  netmask=`echo ${line} | cut -d ',' -f 6`
  gateway=`echo ${line} | cut -d ',' -f 7`
  dns=`echo ${line} | cut -d ',' -f 8`

  bash ${script_dir}/create-userdata.sh \
            ${host} \
            yuanying \
            ${address}  \
            ${netmask} \
            ${gateway} \
            ${dns} > "${userdata_dir}/${host}.cfg"
done
