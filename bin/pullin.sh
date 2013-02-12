#!/bin/sh

FULLPATH=`pwd`
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

    while getopts "rd" flag;  do
            case $flag in
                    d)
                            dry_run="--dry-run"
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

    rsync $other_options $dry_run $recursive -vi $REMOTE_ROOT/$RELPATH $FULLPATH
fi
