# you like this work ?

[!["You like it ?"](https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png)](https://www.buymeacoffee.com/sorriso)

# kube-gitops-longhorn

Install longhorn.io on rancher desktop

> DISCLAMER : This stuff is just for helping people to understand how things work, it is NOT for production use, I do NOT provide any support on it

## prerequisite:

1. Rancher desktop (tested on V1.6.1) installed locally & running (tested on OSX 12.6) with:

   - "containerd" selected as main command tool

   - the "traefik" installed by default desactivated

   - kubernetes v1.4.27 selected / installed

## How to make it working :

1. update "/Users/<username>/Library/Application Support/rancher-desktop/lima/0/lima.yaml" file, by adding at the end of its "provision" section (then, restart rancher desktop):
>- mode: system
>  script: |
>    #!/bin/sh
>    set -o errexit
>    apk add open-iscsi
>    rc-update add iscsid
>    rc-service iscsid start
>    apk add nfs-utils
>    rc-update add nfsmount
>    rc-service nfsmount start

2. run "./0-firstInstall.sh" and wait until all pods & services are up

## OPTIONAL :

the script "./1-update.sh" has been created in order to be used in an "gitOps" approach within ArgoCD

the folder "longhorn" contains the "up-to-date" deployment helm files (to be tuned before run) that can be used by ArgoCD to deploy
