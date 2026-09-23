command -v kubectl > /dev/null && source <(kubectl completion zsh)
command -v kafkactl > /dev/null && source <(kafkactl completion zsh)

# org-specific names live in a *.nogit.zsh file (gitignored):
#   export KUBE_CTX_SUFFIX=... IMDS_ROLE=...

function firstpodname() {
  ENV="$1"
  NS="$2"
  [ -z "$ENV" ] && ENV=staging
  [ -z "$NS" ] && NS=default
  kubectl --context ${ENV}/${KUBE_CTX_SUFFIX:-main} get -n $NS pods -o json | jq -r '.items | map(select(.metadata.labels."app.kubernetes.io/component" == "default") ) | first | .metadata.name'
}

function podcreds() {
  ENV="$1"
  NS="$2"
  POD="$3"
  [ -z "$ENV" ] && ENV=staging
  [ -z "$NS" ] && NS=default
  [ -z "$POD" ] && POD=$( firstpodname $ENV $NS )
  : ${IMDS_ROLE:?set IMDS_ROLE in a *.nogit.zsh file}
  local url="http://169.254.169.254/latest/meta-data/iam/security-credentials/${IMDS_ROLE}"
  kubectl --context ${ENV}/${KUBE_CTX_SUFFIX:-main} exec -n $NS pod/$POD -ti -- \
    node -e "fetch(\"$url\").then(res => res.json().then(x=> console.log(JSON.stringify(x))))"
}

function assumepodcredsrole() {
  jq '.Credentials = . | .Credentials.SessionToken = .Token ' | assumerole
}

# kubectl get nodes -o $NODE_FMT
export NODE_FMT='custom-columns=NAME:metadata.name,STATUS:.status.conditions[?(@.type=="Ready")].status,PURPOSE:metadata.labels.purpose,COLOR:metadata.labels.color,TYPE:metadata.labels.node\.kubernetes\.io\/instance-type,CPU:metadata.labels.karpenter\.k8s\.aws\/instance-memory,RAM:metadata.labels.karpenter\.k8s\.aws\/instance-cpu,CREATED:metadata.creationTimestamp,VERSION:status.nodeInfo.kubeletVersion,IP:status.addresses[?(@.type=="InternalIP")].address,ARCH:status.nodeInfo.architecture'
# kubectl get pods -o $POD_FMT
export POD_FMT='custom-columns=NAME:metadata.name,STATUS:status.phase,IP:status.podIP,PORTS:spec.containers.*.ports.*.containerPort,HOST:status.hostIP,NODE:spec.nodeName,CREATED:metadata.creationTimestamp,IMAGE:spec.containers[].image'
alias kgetnodes="kubectl get nodes -o $NODE_FMT --sort-by metadata.creationTimestamp"

# kubectl krew plugin manager
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
