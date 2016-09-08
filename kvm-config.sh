#!/bin/bash
script_dir=`dirname $0`

function check_host {
  local host_name=$1
  if [[ ${host_pattern} = "" ]]; then
    return 0
  fi
  if [[ ${setting[1]} =~ ${host_pattern} ]]; then
    return 0
  else
    return 1
  fi
}

export UV_KVM_VMS_BRIDGE=${UV_KVM_VMS_BRIDGE:-'br0'}
export UV_KVM_VMS_FILE=${UV_KVM_VMS_FILE:-${script_dir}/vms.csv}
