#!/bin/zsh

# https://www.pulumi.com/docs/iac/cli/environment-variables/
export PULUMI_PARALLEL=40000
export PULUMI_PARALLEL_DIFF=true
export PULUMI_EXPERIMENTAL=true
export PULUMI_CONTINUE_ON_ERROR=true
export PULUMI_DIY_BACKEND_IGNORE_DEPRECATION_WARNING=1

# keep a log of all pulumi commands' outputs, retaining ANSI text colours
pulumi_with_log() {
	mkdir -p ~/log/pulumi
	script -qt 0 ~/log/pulumi/pulumi.$( datestamp ).out pulumi $@
}
## always use PULUMI_AWS_PROFILE AWS profile. Always
pulumi_aws_profile_with_log() {
	AWS_PROFILE=$PULUMI_AWS_PROFILE pulumi_with_log $@
}
# show the output of the most recent pulumi command
alias pulumilog='cat $( ls -1atr ~/log/pulumi/pulumi.*.out | tail -n 1 )'
# alias pulumi='pulumi_with_log'
alias prl='pulumi_aws_profile_with_log'
alias pl='pulumi_with_log'
alias p='pulumi'
