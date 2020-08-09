#!/usr/bin/env sh
# create repo

# create empty README.md

# push to remote repo

createrepo()
{
	#Creates Repo
	GIRINFO="**GIR: Git Repositories**\ngir allows you to create (currently) Github Repositories easily, from the command line.\nUsage:\ngir \$REPO_NAME \$GIT_USERNAME\nCreating a repository named foo with user bar\ngir 'foo' 'bar'\n"
	# Check for necessary arguments, else return help screen
	[[ $# -le 1 ]] && printf "%s $GIRINFO" && return 1
	GIT_REPO=$1
	GIT_USERNAME=$2
	printf "Creating Github repository => '$GIT_REPO'...\n"
	curl -u $GIT_USERNAME https://api.github.com/user/repos -d '{"name":"'$GIT_REPO'"}'
	printf "Repo Created!"
	read -p "Do you want to create an empty README file (y/n)" doreadme
	[[ $doreadme == "y" ]] && createreadme && firstcommit || printf "Exiting..." && return 0 
}

createreadme(){
	# Creates README.md
	printf "Creating README ..."
	touch README.md
	printf " done."

}

firstcommit(){
	# Performs first commit
	ORIGIN_URL="https://github.com/$GIT_USERNAME/$GIT_REPO.git"
	printf "Pushing to remote ..."
	git init
	git add README.md
	git commit -m "Initial Commit"
	git remote add origin "$ORIGIN_URL"
	git push -u origin master
	printf " done.\nAccess Github Repository:\n$ORIGIN_URL" && return 0

}
createrepo $1 $2
