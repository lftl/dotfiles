#!/bin/sh

FULLPATH=`pwd -P`
TOPDIR=$HOME/projects

while [ $FULLPATH != $TOPDIR ] && [ ! -x $FULLPATH/pullin.sh ] && [ ! -f $FULLPATH/.project ]; do
    FULLPATH=`dirname $FULLPATH`;
done

if [ -x $FULLPATH/pullin.sh ]; then
    $FULLPATH/pullin.sh $@;
    exit 1;
fi

if [ -f $FULLPATH/.project ]; then

	other_options="-t"
    source $FULLPATH/.project

    dry_run=""
    recursive=""
    compress=""
	verbose=0

    while getopts "rdzv" flag;  do
            case $flag in
                    v)
                        verbose=1
                        ;;
                    z)
                            compress="-z"
                            ;;
                    d)
                            dry_run="--dry-run"
                            ;;
                    z)
                        compress="-z"
                        ;;
                    r)
                            recursive="-r";
                            ;;
                    \?)
                            echo "Invalid option: -$flag" >&2;
                            exit
                            ;;
            esac
    done

    shift `expr $OPTIND - 1`

    FULLPATH=`readlink -f $1`

    RELPATH=`echo $FULLPATH | sed "s|$LOCAL_ROOT||"`

    FULLPATH=`dirname "$FULLPATH"`;

	if [ $verbose == 1 ] ; then
		echo "rsync $other_options $compress $dry_run $recursive $excludes -vi $REMOTE_ROOT/$RELPATH $FULLPATH"
	fi
    rsync $other_options $compress $dry_run $recursive $excludes -vi $REMOTE_ROOT/$RELPATH $FULLPATH
fi
