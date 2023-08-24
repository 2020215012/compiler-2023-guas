# -*- coding:utf-8 -*-
# author:skipper 
# date:8/19/23 
# time:6:36 PM 
# software: PyCharm

import os
import re
import subprocess
import pandas as pd
import signal

TIMEOUT = 50

T0 = 0


def str_to_num(s:str)->str:
    pattern = r"(\d+)H-(\d+)M-(\d+)S-(\d+)us"
    match = re.search(pattern, s)
    hours = int(match.group(1))
    minutes = int(match.group(2))
    seconds = int(match.group(3))
    microseconds = int(match.group(4))
    second = hours * 3600 + minutes * 60 + seconds
    microsecond = microseconds
    global T0
    T0 += second*1000000 + microsecond
    t = str(second*1000000 + microsecond)
    return t


def touch_out_files(path, dic, num):
    files = list(os.listdir(path=path))
    files.sort()
    in_path = path + '/'
    for f in files:
        if '.sy' in f:
            name = f.split('.')[0]
            put_in = in_path + f
            print(name)

            os.system("cp {} test.sy".format(put_in))
            if 'performance' not in path:
                command = 'compiler_guas/build/compiler -S -o ./test.s test.sy'
            else:
                command = 'compiler_guas/build/compiler -S -o ./test.s test.sy -O1'
            p = subprocess.Popen(command, shell=True, stdout=subprocess.PIPE, preexec_fn=os.setsid)
            try:
                p.wait(TIMEOUT)
            except subprocess.TimeoutExpired:
                os.killpg(os.getpgid(p.pid), signal.SIGTERM)
                dic.append([name, "compile timeout"])
                continue

            cp1 = "cp ./test.s data/{}.s".format(name)
            os.system(cp1)
            continue

            in_file = "{}.in".format(name)
            out_file = in_path + "{}.out".format(name)
            cmd1 = "riscv64-linux-gnu-gcc -static test.s sylib.c -o run"
            if in_file in files:
                cmd2 = "qemu-riscv64 ./run < {}\n".format(in_path + in_file)
            else:
                cmd2 = "qemu-riscv64 ./run\n".format(in_path + in_file)
            os.system(cmd1)

            with open("run.sh", 'w+') as fw:
                fw.write(cmd2 + "echo $?\n")
            fw.close()

            cmd3 = "bash run.sh > out.txt"
            print('running')
            pp = subprocess.Popen(cmd3.encode(), shell=True, stderr=subprocess.PIPE,stdout=subprocess.PIPE, preexec_fn=os.setsid)
            try:
                pp.wait(TIMEOUT)
            except subprocess.TimeoutExpired:
                os.killpg(os.getpgid(pp.pid), signal.SIGTERM)
                dic.append([name, "run time out"])
                global T0
                T0 += TIMEOUT
                continue

            res = open("out.txt").read().replace('', ' ').replace('', ' ').replace('', ' ').replace('\n',                                                                         ' ').split(' ')
            res = [i for i in res if i != '']
            ans = open(out_file).read().replace('\n', ' ').split(' ')
            ans = [i for i in ans if i != '']
            if res == ans or ''.join(res) == ''.join(ans):
                s = pp.stderr.read().decode().split('TOTAL: ')[1][:-1]
                print(s)
                dic.append([name, str_to_num(s)])
            else:
                dic.append([name, "answer False"])
                # print(res,ans,sep='\t')
                print("answer False")
            # break


if __name__ == '__main__':
    path = 'new_performance'
    dic = []
    num = 0
    os.system("rm -rf data")
    os.system("mkdir data")
    os.system("cp sylib.c data/sylib.c")
    os.system("cp sylib.h data/sylib.h")
    os.system("cp riscv_performance.py data/run.py")
    touch_out_files(path=path, dic=dic,num=num)
    pd.DataFrame(dic).to_csv("time_result_{}.csv".format(path))
    print(T0/1000000)
    exit(0)