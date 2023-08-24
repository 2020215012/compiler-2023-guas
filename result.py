# -*- coding:utf-8 -*-
# author:skipper 
# date:8/9/23 
# time:3:15 PM 
# software: PyCharm
import re

import pandas as pd

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


if __name__ == '__main__':
    with open('result.txt', 'r') as f:
        lis0 = f.readlines()
    f.close()

    ans = []

    for i in range(len(lis0)):
        x = lis0[i].split('\t')[0]
        s = lis0[i].split('\t')[-1]
        if 'us' in lis0[i]:
            s = str_to_num(s)
        if 'time' in lis0[i]:
            T0 += 500
        ans.append([x,s])
    pd.DataFrame(ans).to_csv("result.csv")
    print(T0/1000000)