# -*- coding:utf-8 -*-
# author:skipper 
# date:8/19/23 
# time:7:09 PM 
# software: PyCharm
# import os
# import os
# # import os
# #
# # files1 = os.listdir(path='performance')
# # f1 = [i for i in files1 if '.sy' in i]
# #
# # files2 = os.listdir(path='final_performance')
# # f2 = [i for i in files2 if '.sy' in i]
# #
# # for i in f2:
# #     if i not in f1:
# #         print(i)
#
# # os.system("diff final_performance/recursive_call_1.sy final_performance/recursive_call_2.sy")
# # os.system("diff final_performance/recursive_call_2.sy final_performance/recursive_call_3.sy")
# # os.system("diff final_performance/recursive_call_3.sy final_performance/recursive_call_2.sy")
#
#
# # import openpyxl
# #
# # file = './result.xlsx'
# # wb = openpyxl.load_workbook(file)
# # sheet1 = wb['Sheet1']
# # sheet2 = wb['Sheet2']
# #
# # line = 61
# # row = 19
# # for i in range(1, line+1):
# #     for j in range(1, row+1):
# #         sheet2.cell(i, j).value = sheet1.cell(j, i).value
# # wb.save(file)
#
#
# import time
# os.system("riscv64-linux-gnu-gcc -static -O2 test.c sylib.c -o test")
# t1 = time.time()
# os.system("qemu-riscv64 ./test < final_performance/matmul3.in")
# t2 = time.time()
# print("time:\n")
# print(t2-t1)
import os

# import openpyxl
# import pandas as pd
#
# wb = openpyxl.load_workbook('./result.xlsx')
# sheet = wb['Sheet9']
# dic = {}
# for i in range(1, 59):
#     dic[sheet.cell(i, 1).value] = 100*sheet.cell(i, 3).value/sheet.cell(i, 2).value/58
# # sort dict
# dic = sorted(dic.items(), key=lambda x: x[1], reverse=False)
# for i in dic:
#     print(i[0], i[1])
# pd.DataFrame(dic).to_csv('./score.csv', index=False, header=False)


# def func(data, num):
#     if num < 0:
#         return 0
#     else:
#         num -= 1
#         data = data + func(data,num)
#         data = data - func(data, num)
#     return data
#
#
# def fresh(lis):
#     for i in range(len(lis)):
#         lis[i] = 0
#     return lis
#
#
# if __name__ == '__main__':
#     lis = [0 for i in range(30)]
#     for i in range(10):
#         print(func(1, i))

lis0 = os.listdir(path='final_performance')
os.system('rm -rf new_performance')
os.system('mkdir new_performance')
for i in lis0:
    if '01_' in i:
        name = i.replace('01_','')
        os.system("cp final_performance/01_{0} new_performance/{0}".format(name))
    elif '03_' in i:
        name = i.replace('03_', '')
        os.system("cp final_performance/03_{0} new_performance/{0}".format(name))
    elif '04_' in i:
        name = i.replace('04_', '')
        os.system("cp final_performance/04_{0} new_performance/{0}".format(name))
    elif 'recursive_' in i:
        name = i.replace('recursive_', '')
        os.system("cp final_performance/recursive_{0} new_performance/{0}".format(name))
    else:
        os.system("cp final_performance/{0} new_performance/{0}".format(i))