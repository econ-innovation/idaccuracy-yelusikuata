#��һ��
library(readr)
library(stringr)

# ���ù���Ŀ¼�� scientist_pub.csv �ļ����ڵ�λ��
setwd("D:/assignment_idaccuracy")

# ��ȡ scientist_pub.csv �ļ�
scientist_pubs <- read_csv("scientist_pub.csv", show_col_types = FALSE)

# ���Ĺ���Ŀ¼����������ļ���λ��
setwd("D:/assignment_idaccuracy/Aminer")

# ��ȡ���������ļ�
author_files <- list.files(pattern = "\\.csv$", full.names = TRUE)

# ��ʼ�������
matched_pubs <- data.frame()

# ����ÿ�������ļ�
for (file in author_files) {
  # ��ȡ���ߵ���������
  author_data <- read_csv(file, show_col_types = FALSE)
  
  # ����Ƿ���ڱ�����
  if ('����' %in% names(author_data)) {
    # ���ļ�������ȡ uniqueID
    uniqueID <- str_extract(basename(file), "0_[0-9]+")
    
    # ���ַ�ת���ɴ�д���Ա�ƥ��
    author_data$���� <- str_to_upper(author_data$����)
    scientist_pubs$title <- str_to_upper(scientist_pubs$title)
    
    # ɸѡ��ͬʱ������ scientist_pubs �е����ģ����� uniqueID ƥ��
    matched <- scientist_pubs[scientist_pubs$uniqueID == uniqueID & scientist_pubs$title %in% author_data$����, ]
    matched_pubs <- rbind(matched_pubs, matched)
  } else {
    warning(paste("Title column not found in file:", file))
  }
}

# ������յ�ƥ����
print(matched_pubs)



#�ڶ���
library(readr)
library(stringr)
library(dplyr)

setwd("D:/assignment_idaccuracy")
scientist_pubs <- read_csv("scientist_pub.csv", show_col_types = FALSE)

setwd("D:/assignment_idaccuracy/Aminer")
author_files <- list.files(pattern = "\\.csv$", full.names = TRUE)

# ��ʼ�����ڴ洢��׼�ȺͲ�ȫ�ʵ����ݿ�
metrics <- data.frame(uniqueID = character(), precision = numeric(), recall = numeric(), stringsAsFactors = FALSE)

# ����ÿ�������ļ�
for (file in author_files) {
  author_data <- read_csv(file, show_col_types = FALSE)
  
  if ('����' %in% names(author_data)) {
    uniqueID <- str_extract(basename(file), "0_[0-9]+")
    
    author_data$���� <- str_to_upper(author_data$����)
    scientist_pubs$title <- str_to_upper(scientist_pubs$title)
    
    # ɸѡ��ͬʱ������ scientist_pubs �е�����
    matched <- scientist_pubs[scientist_pubs$uniqueID == uniqueID & scientist_pubs$title %in% author_data$����, ]
    
    # ���㾫׼�ȺͲ�ȫ��
    precision <- nrow(matched) / nrow(author_data)
    recall <- nrow(matched) / nrow(scientist_pubs[scientist_pubs$uniqueID == uniqueID, ])
    
    # ��������ӵ�metrics���ݿ���
    metrics <- rbind(metrics, data.frame(uniqueID = uniqueID, precision = precision, recall = recall))
  }
}

# �����׼�ȺͲ�ȫ�ʵĽ��
print(metrics)



#������
library(readr)
library(stringr)
library(dplyr)

setwd("D:/assignment_idaccuracy")
scientist_pubs <- read_csv("scientist_pub.csv", show_col_types = FALSE)

setwd("D:/assignment_idaccuracy/Aminer")
author_files <- list.files(pattern = "\\.csv$", full.names = TRUE)

# ��ʼ����׼�ȺͲ�ȫ�ʵ��ܺ�
total_precision <- 0
total_recall <- 0
num_authors <- 0

# ����ÿ�������ļ�
for (file in author_files) {
  author_data <- read_csv(file, show_col_types = FALSE)
  
  if ('����' %in% names(author_data)) {
    uniqueID <- str_extract(basename(file), "0_[0-9]+")
    
    author_data$���� <- str_to_upper(author_data$����)
    scientist_pubs$title <- str_to_upper(scientist_pubs$title)
    
    # ɸѡ��ͬʱ������ scientist_pubs �е�����
    matched <- scientist_pubs[scientist_pubs$uniqueID == uniqueID & scientist_pubs$title %in% author_data$����, ]
    
    # ���㾫׼�ȺͲ�ȫ��
    precision <- nrow(matched) / nrow(author_data)
    recall <- nrow(matched) / nrow(scientist_pubs[scientist_pubs$uniqueID == uniqueID, ])
    
    # �ۻ���׼�ȺͲ�ȫ��
    total_precision <- total_precision + precision
    total_recall <- total_recall + recall
    num_authors <- num_authors + 1
  }
}

# ����ƽ����׼�ȺͲ�ȫ��
average_precision <- total_precision / num_authors
average_recall <- total_recall / num_authors

# ���ƽ����׼�ȺͲ�ȫ�ʵĽ��
print(paste("Average Precision:", average_precision))
print(paste("Average Recall:", average_recall))