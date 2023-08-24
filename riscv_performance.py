# -*- coding:utf-8 -*-
# author:skipper 
# date:8/19/23 
# time:6:49 PM 
# software: PyCharm

import os
import subprocess
import signal

TIMEOUT = 500
num = 0
files = os.listdir(path='./')
dic = list()
files.sort()
in_outs = os.listdir(path='../new_performance')
for f in files:
    if f == 'test.s' or f == 'run.sh':
        continue
    if '.s' in f:
        name = f.split('.')[0]
        cmd1 = 'gcc -static {}.s sylib.c -o ./test'.format(name)
        os.system(cmd1)
        if "{}.in".format(name) in in_outs:
            cmd2 = './test < ../new_performance/{}.in\n'.format(name)
        else:
            cmd2 = './test\n'
        with open("run.sh", 'w+') as fw:
            fw.write(cmd2 + "echo $?\n")
        fw.close()
        cmd3 = "bash run.sh > out.txt"
        pp = subprocess.Popen(cmd3.encode(), shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE,
                              preexec_fn=os.setsid)
        try:
            pp.wait(TIMEOUT)
        except subprocess.TimeoutExpired:
            os.killpg(os.getpgid(pp.pid), signal.SIGTERM)
            dic.append([name, "run time out"])
            continue
        res = open("out.txt").read().replace('', ' ').replace('', ' ').replace('', ' ').replace('\n', ' ').split(
            ' ')
        out_file = "../new_performance/{}.out".format(name)
        res = [i for i in res if i != '']
        ans = open(out_file).read().replace('\n', ' ').split(' ')
        ans = [i for i in ans if i != '']
        if res == ans or ''.join(res) == ''.join(ans):
            dic.append([name, pp.stderr.read().decode().split('TOTAL: ')[1][:-1]])
            num += 1
        else:
            dic.append([name, "answer False"])
            # print(res, ans, sep='\n')
print(num)
for i in dic:
    print(i[0], i[1], sep='\t')
