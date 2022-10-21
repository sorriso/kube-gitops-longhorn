#!/bin/bash
kubectl create namespace longhorn-system
sleep 2
kubectl apply -f https://raw.githubusercontent.com/longhorn/longhorn/v1.3.2/deploy/longhorn.yaml

#- mode: system
#  script: |
#    #!/bin/sh
#    set -o errexit
#    apk add open-iscsi
#    rc-update add iscsid
#    rc-service iscsid start
#    apk add nfs-utils
#    rc-update add nfsmount
#    rc-service nfsmount start
