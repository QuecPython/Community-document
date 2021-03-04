#!/bin/bash

function usage() {
    echo "uasge: $0 {start|restart|kill|toc|build|help|-h}"
}

function kill_teedoc() {
    ps aux | grep teedoc | grep python3 | awk '{print $2}' | xargs kill -9 >/dev/null
}

function teedoc_build() {
    teedoc build
}

function restart() {
    kill_teedoc
    teedoc_build
    teedoc serve &
}

function start() {
    teedoc serve &
}

function creat_toc() {
    # 读取所有的 sidebar.yml 生成目录
    echo "生成目录"
}

function teedoc_release() {
    # 检查是否存在 out文件
    release_filename=Community-document-$(date "+%Y%m%d-%H%M")
    if [ ! -d "out" ]; then
        teedoc_build
    fi
    tar cf ${release_filename}.tar out
    tar jcf ${release_filename}.tar.bz2 ${release_filename}.tar
    rm -rf ${release_filename}.tar
    mv ${release_filename}.tar.bz2 ..
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
"release")
    teedoc_release
    ;;
"toc")
    # 生成目录
    creat_toc
    ;;
*)
    if [ $# = 0 ]; then
        # 没有参数，默认restart
        restart
    else
        # 错误的参数
        echo "ERROR: $0 $1  错误的参数"
        usage
        exit -1
    fi
    ;;
esac
