#!/usr/bin/env sh
rm -rf out || exit 0;
mkdir out; 
gem install jekyll
jekyll build --destination out
BRANCH=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')
MASTER="master"

if [ "$MASTER" == "$BRANCH" ]; then
	( cd out
	 git init
	 git config user.name "Travis-CI"
	 git config user.email "travis@nodemeatspace.com"
	 cp ../CNAME ./CNAME
	 cp ../countryiso.js ./countryiso.js
	 git add .
	 git commit -m "Deployed to Github Pages"
	 git push --force --quiet "https://${GH_TOKEN}@${GH_REF}" master:gh-pages > /dev/null 2>&1
	)
fi