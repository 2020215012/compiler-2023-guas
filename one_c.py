# -*- coding:utf-8 -*-
# author:skipper 
# date:8/19/23 
# time:11:51 PM 
# software: PyCharm

import os
import signal
import subprocess

TIMEOUT = 50

time_code = ['#include <stdio.h>\n',
             '#include <sys/time.h>\n',
             'struct timeval t;\n',
             'double StartTime, EndTime;\n',
             'double TimeElapsed;\n',
             'int getint(),getch(),getarray(int a[]);\n',
             'float getfloat();\n',
             'int getfarray(float a[]);\n',
             'void putint(int a),putch(int a),putarray(int n,int a[]);\n',
             'void putfloat(float a);\n',
             'void putfarray(int n, float a[]);\n',
             'void putf(char a[], ...);\n']

start_time = 'gettimeofday(&t, NULL);\nStartTime = (double)t.tv_sec*1000000.0 + ((double)t.tv_usec);\n'
stop_time = 'gettimeofday(&t, NULL);\nEndTime = (double)t.tv_sec*1000000.0 + ((double)t.tv_usec);\nTimeElapsed=(EndTime-StartTime)/1000.00;\nfprintf(stderr,"time: %9.4f ms",TimeElapsed);\n'


def run(lis, path):
    dic = []
    for i in lis:
        name = path + '/' + i
        put_in = i.split('.')[0] + '.in'
        codes = open(name, 'r').read()
        codes = codes.replace("starttime();", start_time).replace("stoptime();", stop_time)
        codes = ''.join(time_code) + codes
        # open("test.c", 'w').write(codes)
        os.system("riscv64-linux-gnu-gcc -static test.c sylib.c -o run")
        if 'run' not in os.listdir('./'):
            print("compile error")
            break

        if put_in in os.listdir(path):
            cmd = "qemu-riscv64 ./run < {}\necho $?".format(path + '/' + put_in)
        else:
            cmd = "qemu-riscv64 ./run\necho $?"
        open('run.sh', 'w').write(cmd)
        cmd1 = 'bash run.sh > out.txt'
        p = subprocess.Popen(cmd1, shell=True, stderr=subprocess.PIPE, stdout=subprocess.PIPE, preexec_fn=os.setsid)
        try:
            p.wait(TIMEOUT)
            os.system("rm run")
        except subprocess.TimeoutExpired:
            os.killpg(os.getpgid(p.pid), signal.SIGPIPE)
            print("run time out")
            break
        res = open("out.txt").read().replace('', ' ').replace('', ' ').replace('', ' ').replace('\n', ' ').split(
            ' ')
        res = [i for i in res if i != '']
        ans = open(name.split('.')[0] + '.out').read().replace('\n', ' ').split(' ')
        ans = [i for i in ans if i != '']
        print(p.stderr.read().decode())
        if res == ans or ''.join(res) == ''.join(ans):
            s = p.stderr.read().decode()
            print(s)
        else:
            print('answer false')
            # dic.append([name, "answer False"])
    return dic


if __name__ == '__main__':
    name = '01_mm1.sy'
    path = 'final_performance'
    lis = [name]
    dic = run(lis, path)
