# -*- coding:utf-8 -*-
# author:skipper 
# date:8/19/23 
# time:11:17 PM 
# software: PyCharm


import os
import signal
import subprocess
import time

TIMEOUT = 300


def touch_out_files(path,f,files):
    name = f.split('.')[0]
    in_path = path + '/'
    try:
        put_in = in_path + name + '.sy'
        # print(name)
        print(put_in)
        os.system("cp {} test.sy".format(put_in))
        # exit(0)
        command = 'compiler_guas/build/compiler -S -o test.s test.sy'
        if path == 'performance':
            command = 'compiler_guas/build/compiler -S -o test.s test.sy -O1'
        p = subprocess.Popen(command.encode(),stderr=subprocess.PIPE,stdout=subprocess.PIPE,shell=True, preexec_fn=os.setsid)
        try:
            p.wait(TIMEOUT)
        except subprocess.TimeoutExpired:
            os.killpg(os.getpgid(p.pid),signal.SIGPIPE)
            print("编译超时")
            exit(0)
        # if p.stdout.read().decode() != '':
        # print(p.stdout.read().decode())
        #     print("编译错误")
        #     exit(0)
        err = p.stderr.read().decode()
        # print(err)
        if 'Aborted (core dumped)' in err:
            print(err)
            print("编译错误")
            exit(0)

        in_file = "{}.in".format(name)
        out_file = path + '/' + "{}.out".format(name)
        cmd1 = "riscv64-linux-gnu-gcc -static test.s sylib.c -o run"
        if in_file in files:
            cmd2 = "qemu-riscv64 ./run < {}\n".format(in_path + in_file)
        else:
            cmd2 = "qemu-riscv64 ./run\n".format(in_path + in_file)
        os.system(cmd1)
        print("running")
        # return
        if "run" not in os.listdir("./"):
            print("compile error")
            exit(0)
        # print(cmd2)
        # a = subprocess.getoutput(cmd2)
        with open("run.sh",'w+') as fw:
            fw.write(cmd2+"echo $?\n")
        fw.close()
        cmd3 = "bash run.sh > out.txt"
        pp = subprocess.Popen(cmd3.encode(), shell=True,stdout=subprocess.PIPE,stderr=subprocess.PIPE,preexec_fn=os.setsid)
        try:
            pp.wait(TIMEOUT)
        except subprocess.TimeoutExpired:
            os.killpg(os.getpgid(pp.pid), signal.SIGPIPE)
            print("run time out")
            os.system("rm -rf run")
            exit(0)
        print(pp.stderr.read().decode().split('TOTAL: ')[1][:-1])
        # print(pp.stdout.read().decode())
        # exit(0)
        res = open("out.txt").read().replace('', ' ').replace('', ' ').replace('', ' ').replace('\n', ' ').split(' ')
        res = [i for i in res if i != '']
        ans = open(out_file).read().replace('\n', ' ').split(' ')
        ans = [i for i in ans if i != '']
        # print(res == ans or ''.join(res) == ''.join(ans))
        print(res,ans,sep='\n')
        os.system("rm -rf run")
    except:
        pass


if __name__ == '__main__':
    t1 = time.time()
    paths = ['functional','hidden_functional','new_performance']
    path = paths[2]
    files = list(os.listdir(path=path))
    num = "call_1"
    for i in files:
        if num in i and '.sy' in i:
            name=i
            break
    touch_out_files(path=path,f=name,files=files)
    t2 = time.time()
    print(t2-t1)
    # os.system("cp test.s data3/{}.s".format(num))
    # os.system("cp riscv.py data3/run.py")

'''
compiler_guas/build/compiler -S -o test.s test.sy
riscv64-linux-gnu-gcc -static test.s sylib.c -o run
qemu-riscv64 ./run
echo $?
'''