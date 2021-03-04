#!/usr/bin/env python3
# -*-coding: UTF-8 -*-
# 计划此脚本读取 docs/Quick_start/zh/config.json 文件
# 的 "文档: " 的value ， 然后自动生成目录

import argparse
from argparse import RawTextHelpFormatter
import sys
from loguru import logger
import os
import yaml


def find_file(dir_path, filename):
    if os.path.isdir(dir_path) is not True:
        logger.error("{0} 不是正确的文件路径".format(dir_path))
        return None
    # 去除路径最后一个 /

    file_path = os.path.dirname(dir_path) + '/' + filename
    if os.path.exists(file_path) is not True:
        logger.error("在 {0} 中没有找到 {1} 文件".format(dir_path, filename))
        return None
    return file_path


def creat_toc(args):
    # 1. 找到需要 url 字符串
    dir_list = []
    with open(args.input_file, 'r', encoding='utf-8') as ymlfile:
        cfg = yaml.load(ymlfile, Loader=yaml.SafeLoader)
        List = cfg["navbar"]["items"][1]['items']
        for _ in List:
            # 去除第一个字符
            dir_list.append(_["url"][1:])
    # 2. 根据 url 找到 某一个目录下所有的指定文件
    List_file_path = []
    for _ in dir_list:
        r = find_file("docs/" + _, "sidebar.yaml")
        if r is not None:
            List_file_path.append(r)
    logger.debug("找到了 {}".format(List_file_path))

    # 3. 最后开始合并yml 文件
    if os.path.exists(args.out_file) is True:
        logger.debug("删除 {}".format(args.out_file))
        os.remove(args.out_file)
    for _ in List_file_path:
        cmd = "cat {0} >> {1}".format(_, args.out_file)
        logger.debug("执行 {} 命令".format(cmd))
        os.system(cmd)
    pass


# 找到所有的 sidebar.yaml
def main(argv):
    parser = argparse.ArgumentParser(description="自动生成目录",
                                     formatter_class=RawTextHelpFormatter)
    parser.add_argument("--out_file",
                        "-o",
                        type=str,
                        default="Quecpython_toc.yml",
                        help='输出目录 (eg: -o Quecpython_toc.yml)')
    parser.add_argument(
        "--input_file",
        "-i",
        type=str,
        default="docs/Quecpython_intro/zh/config.json",
        help='输出目录 (eg: -i docs/Quecpython_intro/zh/config.json)')
    parser.add_argument("--action",
                        type=str,
                        default="toc",
                        help="""指定动作  
                        --action {toc|copy}  
                        toc  生成总目录 
                        copy 将 {input_file} 文件同时复制到其他的路径下面去""")
    args = parser.parse_args(args=argv)
    logger.debug(args.out_file)
    logger.debug(args.input_file)

    if os.path.isfile(args.input_file) is False:
        logger.error("错误的 --input_file 参数, 没有找到 {0}".format(args.input_file))
        exit(1)

    if args.action == "toc":
        creat_toc(args)
    elif args.action == "copy":
        logger.error("此功能等待完善")


if __name__ == "__main__":
    main(sys.argv[1:])