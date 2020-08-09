# Gir: Git Repositories

Simple shell script to create git remote repositories from the command line. Currently supports only Github repos

# Installation

You should, of course, have a shell interpreter and access to a terminal

You can either give the .sh file executable permissions:

```
chmod +x gir.sh
```

AND store it globally under a directory included inside your $PATH: (e.g. /usr/local/bin, depending on your $PATH)

Afterwards you can run gir in various ways, depending on your preference.

# Usage

## As an Alias (NOTE: Needs to be setup by the user)

Inside your desired repository directory, run

```
gir *$REPO_NAME* *$USER_NAME*
```

## Without an alias

```
gir.sh *$REPO_NAME* *$USER_NAME*
```

## Copying gir sh to your desired repo directory and running it from there (NOT RECOMMENDED!)

```
./gir.sh *$REPO_NAME* *$USER_NAME*
```

You will be prompted for various options such as preferred URL method (SSH or HTTPS), or if you want to add an empty README.md
