#!/bin/bash

APP_NAME="cou-central-erp"
APP_PATH="./bin/$APP_NAME"
PID_FILE="/tmp/$APP_NAME.pid"
LOG_FILE="/tmp/$APP_NAME.log"

start() {
    if [ -f "$PID_FILE" ]; then
        echo "$APP_NAME is already running (PID: $(cat $PID_FILE))"
    else
        echo "Starting $APP_NAME..."
        nohup $APP_PATH > $LOG_FILE 2>&1 &
        echo $! > $PID_FILE
        echo "$APP_NAME started with PID $(cat $PID_FILE)"
    fi
}

stop() {
    if [ -f "$PID_FILE" ]; then
        PID=$(cat $PID_FILE)
        echo "Stopping $APP_NAME (PID: $PID)..."
        kill $PID
        rm $PID_FILE
        echo "$APP_NAME stopped"
    else
        echo "$APP_NAME is not running"
    fi
}

status() {
    if [ -f "$PID_FILE" ]; then
        PID=$(cat $PID_FILE)
        if ps -p $PID > /dev/null; then
            echo "$APP_NAME is running (PID: $PID)"
        else
            echo "$APP_NAME is not running (stale PID file)"
            rm $PID_FILE
        fi
    else
        echo "$APP_NAME is not running"
    fi
}

case "$1" in
    start)   start ;;
    stop)    stop ;;
    restart) stop; start ;;
    status)  status ;;
    *)       echo "Usage: $0 {start|stop|restart|status}" ;;
esac

exit 0
