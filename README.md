Feature Workflow

This workflow lets me work with features, push changes, and selectively release them to staging or production using Graphite, with minimal thinking.

1️⃣ Setup Mac environment
./feature.sh feature_install

Installs Graphite CLI if missing


2️⃣ Create a new feature
./feature.sh create_feature <feature-name>


Creates a feature branch from develop

Example:

./feature.sh create_feature remove_bbmobile_features

3️⃣ Add commits to the feature
./feature.sh add_stack_commit "<commit-message>"


Adds a commit to the current feature stack

You can do this multiple times

Example:

./feature.sh add_stack_commit "fix: remove check for blipp is for mobile or desktop"
./feature.sh add_stack_commit "fix: remove unnecessary check for user agent"

4️⃣ Push changes / create PR
./feature.sh push_stack


Creates or updates a PR for the current stack

Can be done multiple times as you add more commits

Example:

./feature.sh add_stack_commit "chore: remove unused logging"
./feature.sh push_stack

5️⃣ Merge feature into develop
./feature.sh land_feature


Lands the PR into develop

Branch is kept intact for later releases

6️⃣ Create a release branch from the feature
./feature.sh create_release_branch <feature-name>


Creates release/<feature-name> from your feature branch

7️⃣ Merge feature to staging
./feature.sh merge_to_staging <feature-name>


Rebases release branch onto staging

Resolves conflicts automatically in favor of your feature

Lands changes into staging

8️⃣ Merge feature to master (prod release)
./feature.sh merge_to_master <feature-name>


Rebases release branch onto master

Resolves conflicts automatically in favor of your feature

Lands changes into master

9️⃣ View features
./feature.sh list_features


Lists all features, removing feature/ and release/ prefixes

Shows only distinct feature names

Example output:

remove_bbmobile_features
step-1

1️⃣0️⃣ View all features
./feature.sh list_branches


Shows Graphite-aware list of all features
