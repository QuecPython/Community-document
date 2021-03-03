#!/bin/bash

function usage() {
    echo "uasge: $0 {start|restart|kill|build|help|-h}"
}

function kill_teedoc() {
    ps aux | grep teedoc | grep python3 | awk '{print $2}' | xargs kill -9 >/dev/null
}

function teedoc_build() {
    teedoc build
}

function restart() {
    kill_teedoc
    rm -rf out
    teedoc_build 
    teedoc_build
    teedoc serve &
}

function start() {
    teedoc serve &
}

case $1 in
"start")
    start
    ;;
"restart")
    restart
    ;;
"kill")
    kill_teedoc
    ;;
"help")
    usage
    ;;
"build")
    teedoc_build
    ;;
"-h")
    usage
    ;;
*)
    restart
    ;;
esac
