### 标题
这是合肥工业大学2023年计算机系统能力大赛——编译系统设计赛（华为毕昇杯）三等奖作品，源码和测试代码

#### 测试样例
https://gitlab.eduxiji.net/nscscc/compiler2023/-/tree/master

#### 配置
1. riscv64-linux-gnu-gcc交叉编译器
2. qemu-riscv64模拟器

#### 运行
1. 首先运行build.sh构建compiler项目
2. 本地运行，运行test_performance.py，评测performance样例，得到运行时间和正确性信息
3. starfive开发板运行，在test_performance.py中，解除57-58行的注释，执行test_performance.py得到文件夹data，将data文件ssh传输到开发板，执行
> python3 run.py > result.txt

> os.system(cp1) \
> continue