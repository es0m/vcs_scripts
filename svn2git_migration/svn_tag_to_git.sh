# looks up the svn revision for all tags, creates an annotated git tag for corresponding git SHA. 
# git-svn fetch must include the svn tag revisions (usually as branches)

# arg1: submodule of your svn directory 
# assumes you are in your git directory (with .git/config)
#svn repository url pointing to your tags: 
SR=file:///srv/svn/auto_stereo/tags/
# assumes you are in your git directory (with .git/config)

PROJECT=$1
REVS=`svn ls -v $SR/$PROJECT | grep -v "\./" | awk '{print $1}'`
TAGS=`svn ls -v $SR/$PROJECT | grep -v "\./" | awk '{print $6}'`
# first find the revision where a given tag was created
#TAGREV=`svn log $SR/$TAG -v --stop-on-copy`
#echo found tag revision $TAGREV
revs=($REVS)
tags=($TAGS)
lenrevs=${#revs[@]}
lentags=${#tags[@]}

echo Found ${lenrevs} revisions: $REVS
echo Found ${lentags} tags: $TAGS

if [ "$lenrevs" -ne "$lentags" ];
then
  echo "Cannot extract correct number of tags and revisions from svn. Giving up."
  exit
fi
for ((i=0; i<${lentags}; i++ ));
do
  echo ${revs[i]} maps to tag name ${tags[i]}
  tag=${tags[i]%/}
  rev=`git svn find-rev r${revs[i]} tags/$PROJECT/${tag}`
  msg=`git log --format=%B -n 1 $rev | grep -v git-svn-id`
  echo Git sha $rev has commit message $msg
  git tag -a $PROJECT-${tag} $rev -m "git tag from svn revision $rev: $msg"
done
   

# now look for this revision in git

