#!/bin/zsh
export GITHUB_TOKEN=$( gh auth token )
export GIT_HOME="$HOME/git"

gitcommitandpush() {
	git commit -m "$0" && git push
}
alias gp=gitcommitandpush

gitstashpull() { git stash -m "pull" && git pull && git stash pop }
gitrestorepullmaster() { git restore . && git checkout master && git pull }

gitmasterall() {
    set -x
    MODIFIED=""
    grep -v '\(master\|main\)$' $GIT_HOME/*/.git/HEAD \
        | sed -e 's|/.git/HEAD:ref: refs/heads/| |' \
        | while read -r repo branch; do
            git -C "$repo" status --porcelain=v1 | grep -c '^ M' | read -r CHANGES
            if [[ $CHANGES -eq 0 ]]; then
                git -C "$repo" checkout master \
                    && git -C "$repo" pull
            else
                MODIFIED+="$( basename $repo ) $branch $CHANGES\n"
            fi
        done

    echo $MODIFIED | column -t
    set +x
}
