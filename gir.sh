#!/usr/bin/env sh
# create repo

# create empty README.md

# push to remote repo

# UPDATE 2020-12-27
# Support for new Github tokens integrated

createrepo()
{
	#Creates Repo
	GIRINFO="**GIR: Git Repositories**\ngir allows you to create (currently) Github Repositories easily, from the command line.\nUsage:\ngir \$REPO_NAME \$GIT_USERNAME\nCreating a repository named foo with user bar\ngir 'foo' 'bar'\n"
	# Check for necessary arguments, else return help screen
	[[ $# -le 1 ]] && printf "%s $GIRINFO" && return 1
	read -p "Do you want to establish SSH as your primary URL? (If not, HTTPS will be used) (y/n)" usessh
	GIT_REPO=$1
	GIT_USERNAME=$2
	printf "Creating Github repository => '$GIT_REPO'...\n"
	curl -u $GIT_USERNAME:$PERSONAL_GITHUB_ACCESS_TOKEN https://api.github.com/user/repos -d '{"name":"'$GIT_REPO'"}' > /dev/null || printf "ERR: Unkown Error Ocurred"
	printf "Repo Created!\n"
	initrepo $usessh
	read -p "Do you want to create an empty README file (y/n):" doreadme
	[[ $doreadme == "y" ]] && createreadme || printf "Exiting..."; return 0 
}

createreadme(){
	# Creates README.md
	printf "\nCreating README ..."
	touch README.md
	printf " done."
	firstcommit

}

initrepo(){
	# Initializes repo 
	ORIGIN_URL="https://github.com/$GIT_USERNAME/$GIT_REPO.git"
	git init
	git remote add origin "$ORIGIN_URL"
	[[ $1 == "y" ]] && git config --global url."git@github.com:".insteadOf "https://github.com/" && printf "Repo setup to use SSH Successfully!\n" || printf "Repo will use HTTPS\n"

}

firstcommit(){
	# Performs first commit
	printf "\nPushing to remote ..."
	git add README.md
	git commit -m "Initial Commit"
	git push -u origin master
	printf " done.\nAccess Github Repository:\n$ORIGIN_URL\n"

}
createrepo $1 $2
