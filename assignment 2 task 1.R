#第一题
# 载入readr包
library(readr)

# 设置工作目录
setwd("D:/assignment_idaccuracy/Aminer")

# 获取当前工作目录下的所有文件
files <- list.files(pattern = "\\.csv$")

# 初始化一个空的data.frame用于存储合并后的数据
combined_data <- data.frame()

# 循环遍历文件
for (file in files) {
  # 读取文件
  data <- read_csv(file)
  
  # 将文件数据合并到总的data.frame中
  combined_data <- rbind(combined_data, data)
}

# 输出合并后的data.frame
print(combined_data)

#第二题
# 载入readr包
library(readr)

# 设置工作目录
setwd("D:/assignment_idaccuracy/Aminer")

# 获取当前工作目录下的所有CSV文件
files <- list.files(pattern = "\\.csv$")

# 使用lapply读取所有文件，并将结果存储在列表中
data_list <- lapply(files, read_csv)

# 使用do.call和rbind合并所有数据框
combined_data <- do.call(rbind, data_list)

# 输出合并后的data.frame
print(combined_data)

#第三题
# 将代码保存为一个 .R 文件，命名为 merge_csv_files.R

# 载入必要的库
library(readr)

# 从命令行参数获取路径
args <- commandArgs(trailingOnly = TRUE)
path <- args[1]

# 设置工作目录
setwd(path)

# 获取当前工作目录下的所有CSV文件
files <- list.files(pattern = "\\.csv$")

# 使用lapply读取所有文件，并将结果存储在列表中
data_list <- lapply(files, read_csv)

# 使用do.call和rbind合并所有数据框
combined_data <- do.call(rbind, data_list)

# 输出合并后的data.frame
print(combined_data)

#要运行这个脚本，在命令行里调用R并传递脚本路径与参数即可
#Rscript merge_csv_files.R "D:/assignment_idaccuracy/Aminer"