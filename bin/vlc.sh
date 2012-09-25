#! /bin/sh

DAEMON=/usr/local/bin/vlc
ARGS=" -v 0 --quiet-synchro"

test -x $DAEMON || exit 0

# Source defaults file; edit that file to configure this script.
ENABLED=1
PARAMS=""
if [ vlcsettings ]; then
  . vlcsettings
fi

test "$ENABLED" != "0" || exit 0

case "$1" in
    start)
        echo "Starting VideoLAN"
        start-stop-daemon --start --chuid www-data --exec $DAEMON -- -d $ARGS $PARAMS
    ;;
  stop)
        echo "Stopping VideoLAN" $DAEMON
        start-stop-daemon --stop --chuid www-data --exec $DAEMON
    ;;
  force-reload|restart)
    $0 stop
    $0 start
    ;;
  *)
    echo "Usage: ./vlc {start|stop|restart|force-reload}"
    exit 1
    ;;
esac

exit 0