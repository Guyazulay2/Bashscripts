#!/bin/bash


echo "Enter your Github name >:"
read USERNAME

git config --global user.name $USERNAME

echo "Enter your repository name? >:"
read REPO_NAME

echo "Enter a repo description: "
read DESCRIPTION


echo "what is the path to your local project directory? >:"
read PROJECT_PATH

cd "$PROJECT_PATH"

echo "Enter the file that you want to add for example [ Text.sh ] >:"
read FILE

git init
git add $FILE
git commit -m 'initial commit'

curl -u ${USERNAME} https://api.github.com/user/repos -d "{\"name\": \"${REPO_NAME}\", \"description\": \"${DESCRIPTION}\"}"

echo "Enter the name of the branch >:"
read BRANCH

git push origin $BRANCH


git remote add origin https://github.com/${USERNAME}/${REPO_NAME}.git
git push --set-upstream origin $BRANCH

cd "$PROJECT_PATH"

echo "Done. Go to https://github.com/$USERNAME/$REPO_NAME to see."
