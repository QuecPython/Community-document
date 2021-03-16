#!/bin/bash

function usage() {
    echo "uasge: $0 {start|restart|kill|toc|build|publish|release_src|release|help|-h}"
}

function kill_teedoc() {
    ps aux | grep teedoc | grep python3 | awk '{print $2}' | xargs kill -9 >/dev/null
}

function teedoc_build() {
    teedoc build
}

function restart() {
    teedoc_build
    kill_teedoc
    teedoc serve &
}

function start() {
    teedoc serve &
}

function creat_toc() {
    # 读取所有的 sidebar.yml 生成目录
    echo "生成目录"
    python3 script/auto_creat_toc.py --out_file Quecpython_toc.yml --input_file docs/Quecpython_intro/zh/config.json --action toc

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

function teedoc_src_release() {
    release_filename=Community-document-src-$(date "+%Y%m%d-%H%M")
    /home/dist/teedoc
}

function teedoc_publish_to_server() {
    OUT_DOC_TOP_DIC=./out/doc/
    cp ${OUT_DOC_TOP_DIC}/doc/*.html ${OUT_DOC_TOP_DIC}
    cp ${OUT_DOC_TOP_DIC}/doc/*.ico ${OUT_DOC_TOP_DIC}
    cp ${OUT_DOC_TOP_DIC}/doc/*.json ${OUT_DOC_TOP_DIC}

    case $1 in
    "root@192.168.25.215:/home/dist/doc")
        echo "确认发布到服务器: "
        sudo chmod -R 777 .
        rsync ${OUT_DOC_TOP_DIC}/ $1 -r -i
        ;;
    *)
        echo "发布到 /www/wwwroot/test.com/doc 文件夹"
        sudo chmod -R 777 .
        rsync ${OUT_DOC_TOP_DIC}/ /www/wwwroot/test.com/doc -r -i > /dev/null
        ;;
    esac
}

function copy_file() {
    python3 script/auto_creat_toc.py --input_file pages/index/zh/config.json --action copy
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
"--help")
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
"release_src")
    teedoc_src_release
    ;;
"publish")
    teedoc_publish_to_server $2
    ;;

"toc")
    # 生成目录
    creat_toc
    ;;
"copy")
    # 覆盖相同的文档
    copy_file
    ;;
*)
    if [ $# = 0 ]; then
        # 没有参数，默认
        teedoc_build
    else
        # 错误的参数
        echo "ERROR: $0 $1  错误的参数"
        usage
        exit -1
    fi
    ;;
esac
