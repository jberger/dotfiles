alias rscp="rsync -ah -r --no-i-r --info=progress2"
alias xmlpretty="xmllint --format" # requires xmllib2
alias unlock="xattr -dr com.apple.quarantine" # remove the apple warning about being downloaded from the internet
alias ll="ls -lah"
# convert json formatted k8s configmaps and secrets to environment file format
# e.g. kubectl get configmap myconfig -o json | cm2env > envfile
# adapted from https://www.jujens.eu/posts/en/2021/Mar/21/kubectl-cfg-to-env/
alias cm2env='jq -r '\''.data | to_entries | map(.key + "=" + (.value)) | .[]'\'
alias secret2env='jq -r '\''.data | map_values(@base64d) | to_entries | map(.key + "=" + (.value)) | .[]'\'

dirsize(){ du -hd 1 "$@" | sort -h; }
