#!/bin/bash
script_dir=`dirname $0`

export UV_KVM_VMS_BRIDGE=${UV_KVM_VMS_BRIDGE:-'br0'}
export UV_KVM_VMS_FILE=${UV_KVM_VMS_FILE:-${script_dir}/vms.csv}
