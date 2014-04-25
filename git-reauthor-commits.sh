#!/bin/sh
#
# Change the commits in a repo from one email to another
export FROM_EMAIL=from_email@test.com
export TO_EMAIL=to_email@test.com

echo "Changing git author from [$FROM_EMAIL] to [$TO_EMAIL]"
echo "Are you sure you want to do this?"
exit 1

git filter-branch --env-filter '
	if test "$GIT_AUTHOR_EMAIL" = "$FROM_EMAIL"
	then
		GIT_AUTHOR_EMAIL=$TO_EMAIL
		export GIT_AUTHOR_EMAIL
	fi
	if test "$GIT_COMMITTER_EMAIL" = "$FROM_EMAIL"
	then
		GIT_COMMITTER_EMAIL=$TO_EMAIL
		export GIT_COMMITTER_EMAIL
	fi
' -- --all
