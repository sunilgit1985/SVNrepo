#!/bin/sh

export DATE='20170711'
export current_dir=`pwd`
export dest_dir=/inv/www/invessence/ROOT/WEB-INF/classes/com/invessence/web

tar cvf ROOT.${DATE}.tar /inv/www/invessence/ROOT*
mv ROOT.${DATE}.tar  /inv/www/invessence/backup/ROOT.${DATE}.tar.$$

for file in `find . -name "*class" -type f -print`
do
  if [ -f ${dest_dir}/${file} ]
   then
	echo "Can move: $file"
	cp -p ${file} ${dest_dir}/${file}
   else
	echo "Skip: $file"
   fi
done

