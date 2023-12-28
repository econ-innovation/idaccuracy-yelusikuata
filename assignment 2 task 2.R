#第一题
library(readr)
library(stringr)

# 设置工作目录到 scientist_pub.csv 文件所在的位置
setwd("D:/assignment_idaccuracy")

# 读取 scientist_pub.csv 文件
scientist_pubs <- read_csv("scientist_pub.csv", show_col_types = FALSE)

# 更改工作目录到存放作者文件的位置
setwd("D:/assignment_idaccuracy/Aminer")

# 获取所有作者文件
author_files <- list.files(pattern = "\\.csv$", full.names = TRUE)

# 初始化结果集
matched_pubs <- data.frame()

# 遍历每个作者文件
for (file in author_files) {
  # 读取作者的论文数据
  author_data <- read_csv(file, show_col_types = FALSE)
  
  # 检查是否存在标题列
  if ('标题' %in% names(author_data)) {
    # 从文件名中提取 uniqueID
    uniqueID <- str_extract(basename(file), "0_[0-9]+")
    
    # 将字符转化成大写，以便匹配
    author_data$标题 <- str_to_upper(author_data$标题)
    scientist_pubs$title <- str_to_upper(scientist_pubs$title)
    
    # 筛选出同时存在于 scientist_pubs 中的论文，并且 uniqueID 匹配
    matched <- scientist_pubs[scientist_pubs$uniqueID == uniqueID & scientist_pubs$title %in% author_data$标题, ]
    matched_pubs <- rbind(matched_pubs, matched)
  } else {
    warning(paste("Title column not found in file:", file))
  }
}

# 输出最终的匹配结果
print(matched_pubs)



#第二题
library(readr)
library(stringr)
library(dplyr)

setwd("D:/assignment_idaccuracy")
scientist_pubs <- read_csv("scientist_pub.csv", show_col_types = FALSE)

setwd("D:/assignment_idaccuracy/Aminer")
author_files <- list.files(pattern = "\\.csv$", full.names = TRUE)

# 初始化用于存储精准度和查全率的数据框
metrics <- data.frame(uniqueID = character(), precision = numeric(), recall = numeric(), stringsAsFactors = FALSE)

# 遍历每个作者文件
for (file in author_files) {
  author_data <- read_csv(file, show_col_types = FALSE)
  
  if ('标题' %in% names(author_data)) {
    uniqueID <- str_extract(basename(file), "0_[0-9]+")
    
    author_data$标题 <- str_to_upper(author_data$标题)
    scientist_pubs$title <- str_to_upper(scientist_pubs$title)
    
    # 筛选出同时存在于 scientist_pubs 中的论文
    matched <- scientist_pubs[scientist_pubs$uniqueID == uniqueID & scientist_pubs$title %in% author_data$标题, ]
    
    # 计算精准度和查全率
    precision <- nrow(matched) / nrow(author_data)
    recall <- nrow(matched) / nrow(scientist_pubs[scientist_pubs$uniqueID == uniqueID, ])
    
    # 将结果添加到metrics数据框中
    metrics <- rbind(metrics, data.frame(uniqueID = uniqueID, precision = precision, recall = recall))
  }
}

# 输出精准度和查全率的结果
print(metrics)



#第三题
library(readr)
library(stringr)
library(dplyr)

setwd("D:/assignment_idaccuracy")
scientist_pubs <- read_csv("scientist_pub.csv", show_col_types = FALSE)

setwd("D:/assignment_idaccuracy/Aminer")
author_files <- list.files(pattern = "\\.csv$", full.names = TRUE)

# 初始化精准度和查全率的总和
total_precision <- 0
total_recall <- 0
num_authors <- 0

# 遍历每个作者文件
for (file in author_files) {
  author_data <- read_csv(file, show_col_types = FALSE)
  
  if ('标题' %in% names(author_data)) {
    uniqueID <- str_extract(basename(file), "0_[0-9]+")
    
    author_data$标题 <- str_to_upper(author_data$标题)
    scientist_pubs$title <- str_to_upper(scientist_pubs$title)
    
    # 筛选出同时存在于 scientist_pubs 中的论文
    matched <- scientist_pubs[scientist_pubs$uniqueID == uniqueID & scientist_pubs$title %in% author_data$标题, ]
    
    # 计算精准度和查全率
    precision <- nrow(matched) / nrow(author_data)
    recall <- nrow(matched) / nrow(scientist_pubs[scientist_pubs$uniqueID == uniqueID, ])
    
    # 累积精准度和查全率
    total_precision <- total_precision + precision
    total_recall <- total_recall + recall
    num_authors <- num_authors + 1
  }
}

# 计算平均精准度和查全率
average_precision <- total_precision / num_authors
average_recall <- total_recall / num_authors

# 输出平均精准度和查全率的结果
print(paste("Average Precision:", average_precision))
print(paste("Average Recall:", average_recall))