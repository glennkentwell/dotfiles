#!/bin/zsh

listrds() {
	for profile in "$@"; do
		echo "\n*** *** " $profile;
			aws --profile $profile rds describe-db-instances \
			| jq -r '.DBInstances[] | "	" + .DBInstanceIdentifier + " v" + .EngineVersion + " " + .DBInstanceClass + " (" +  .DBParameterGroups[0].DBParameterGroupName + ") " + .Endpoint.Address, " "';
	done
}

amifind() {
  if [[ $# -eq 0 || "$1" == "-h" || "$1" == "--help" ]]; then
    echo "Region:\t${REGION}\nEKS Version:\t${EKSVERSION}\nCreation date:\t${YEAR}*\n\nUsage: amifind [region] [eks version]\n e.g.:\tamifind ap-southeast-2 1.25\n\n"
    return
  fi

  REGION=${1-ap-southeast-2}
  EKSVERSION=${2-1.29}
  YEAR=$( date +%Y )
  aws --region $REGION ec2 describe-images --filters \
      "Name=creation-date,Values=${YEAR}*" \
      "Name=image-type,Values=machine" \
      "Name=name,Values=amazon-eks-node-al2023-arm64-standard-${EKSVERSION}*,amazon-eks-node-al2023-x86_64-standard-${EKSVERSION}*" \
      --owners amazon \
      | jq -rc  '.Images | group_by(.Architecture) | .[] | sort_by(.CreationDate) | .[-25:] | .[] | "- " + .Name + ": " + .ImageId '
}

# run with
#  awsalways &
# and if using SSO clicker browser extension it will refresh SSO creds before expiry time
ssoalways() { while true; do left=$(( $( date -ujf '%Y-%m-%dT%H:%M:%SZ' $( jq -r '.expiresAt' $( grep -l awsapps $HOME/.aws/sso/cache/*json ) ) +%s ) - $(  date +%s ) )); [[ $left -gt 300 ]] && sleep $(( $left - 300 )) || aws sso login; done }

function assumerole() {
  $( jq -r '{ AWS_ACCESS_KEY_ID: .Credentials.AccessKeyId, AWS_SECRET_ACCESS_KEY: .Credentials.SecretAccessKey, AWS_SESSION_TOKEN: .Credentials.SessionToken } | keys[] as $k | "export \($k)=\(.[$k])"' )
}

_s5cmd_cli_zsh_autocomplete() {
	local -a opts
	local cur
	cur=${words[-1]}
	opts=("${(@f)$(${words[@]:0:#words[@]-1} "${cur}" --generate-bash-completion)}")

	if [[ "${opts[1]}" != "" ]]; then
	  _describe 'values' opts
	else
	  _files
	fi
}

compdef _s5cmd_cli_zsh_autocomplete s5cmd
