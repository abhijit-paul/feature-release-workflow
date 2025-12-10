#!/bin/bash

# Usage: ./feature.sh feature_install
feature_install() {
    echo "Installing Graphite..."

    # Install Graphite CLI
    if ! command -v gt >/dev/null 2>&1; then
        echo "Installing Graphite CLI..."
        brew install graphite
    else
        echo "Graphite CLI already installed"
    fi

    echo "✅ You can now use the feature workflow."
}


# Usage: ./feature.sh create_feature <feature-name>
create_feature() {
    FEATURE=$1
    git checkout develop
    gt branch create feature/$FEATURE
    echo "✅ Created feature branch: feature/$FEATURE from develop"
}

# Usage: ./feature.sh list_features
list_features() {
    gt branch list \
        | grep -E '^(feature/|release/)' \
        | sed -E 's#^(feature/|release/)##' \
        | sort -u
}

# Usage: ./feature.sh add_stack_commit <commit-message>
add_stack_commit() {
    MESSAGE="$*"
    gt stack create "$MESSAGE"
    echo "✅ Added commit to stack: $MESSAGE"
}

# Usage: ./feature.sh push_stack
push_stack() {
    gt up
    echo "✅ PR created/updated for current stack"
}

# Usage: ./feature.sh land_feature
land_feature() {
    gt land
    echo "✅ Feature PR merged to base branch"
}

# Usage: ./feature.sh create_release_branch <feature-name>
create_release_branch() {
    FEATURE=$1
    gt checkout feature/$FEATURE
    gt branch create release/$FEATURE
    echo "✅ Created release branch: release/$FEATURE"
}

# Usage: ./feature.sh merge_to_staging <feature-name>
merge_to_staging() {
    FEATURE=$1
    gt checkout release/$FEATURE
    gt up -r staging --strategy-option=ours
    gt land -d staging
    echo "✅ Feature $FEATURE merged to staging"
}

# Usage: ./feature.sh merge_to_master <feature-name>
merge_to_master() {
    FEATURE=$1
    gt checkout release/$FEATURE
    gt up -r master --strategy-option=ours
    gt land -d master
    echo "✅ Feature $FEATURE merged to master"
}


COMMAND=$1
shift

case $COMMAND in
    feature_install) feature_install ;;
    create_feature) create_feature "$@" ;;
    list_features) list_features ;;
    add_stack_commit) add_stack_commit "$@" ;;
    push_stack) push_stack ;;
    land_feature) land_feature ;;
    create_release_branch) create_release_branch "$@" ;;
    merge_to_staging) merge_to_staging "$@" ;;
    merge_to_master) merge_to_master "$@" ;;
    *)
        echo "Usage: $0 {feature_install|create_feature|list_features|add_stack_commit|push_stack|land_feature|create_release_branch|merge_to_staging|merge_to_master} [feature-name/message]"
        exit 1
        ;;
esac
