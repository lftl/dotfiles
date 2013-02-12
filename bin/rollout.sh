#!/bin/sh

FULLPATH=`pwd`

while [ $FULLPATH != $HOME ] && [ ! -x $FULLPATH/rollout.sh ] && [ ! -f $FULLPATH/.project ]; do
    FULLPATH=`dirname $FULLPATH`;
done

if [ -x $FULLPATH/rollout.sh ]; then
    $FULLPATH/rollout.sh $@;
    exit 1;
fi

if [ -f $FULLPATH/.project ]; then

	other_options="-t"
    source $FULLPATH/.project

    dry_run=""
    recursive=""
    compress=""

    while getopts "drz" flag;  do
        case $flag in
            z)
                compress="-z"
                ;;
            d)
                dry_run="--dry-run"
                ;;
            r)
                recursive="-r"
                ;;
            \?)
                echo "Invalid option: -$flag" >&2;
                exit
                ;;
        esac
    done

    shift `expr $OPTIND - 1`

    if [ ! -n "$1" ] ; then
        echo "No filename given"
        exit;
    fi

    FULLPATH=`readlink -f $1`
    RELPATH=`echo $FULLPATH | sed -e "s|$LOCAL_ROOT||"`

    if [ "$FULLPATH" == "$LOCAL_ROOT" ] ; then
        FULLPATH="$FULLPATH/"
    fi

    if [ -d $FULLPATH ] && [ "$RELPATH" != "" ] ; then
        RELPATH=`dirname $RELPATH`;
        if [ "$RELPATH" == "/" ] ; then
            RELPATH=""
        else
            RELPATH="$RELPATH/"
        fi
    fi

    rsync $other_options -vi $compress $excludes $dry_run $recursive $FULLPATH $REMOTE_ROOT$RELPATH
fi
