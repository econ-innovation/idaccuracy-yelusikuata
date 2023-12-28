#��һ��
# ����readr��
library(readr)

# ���ù���Ŀ¼
setwd("D:/assignment_idaccuracy/Aminer")

# ��ȡ��ǰ����Ŀ¼�µ������ļ�
files <- list.files(pattern = "\\.csv$")

# ��ʼ��һ���յ�data.frame���ڴ洢�ϲ��������
combined_data <- data.frame()

# ѭ�������ļ�
for (file in files) {
  # ��ȡ�ļ�
  data <- read_csv(file)
  
  # ���ļ����ݺϲ����ܵ�data.frame��
  combined_data <- rbind(combined_data, data)
}

# ����ϲ����data.frame
print(combined_data)

#�ڶ���
# ����readr��
library(readr)

# ���ù���Ŀ¼
setwd("D:/assignment_idaccuracy/Aminer")

# ��ȡ��ǰ����Ŀ¼�µ�����CSV�ļ�
files <- list.files(pattern = "\\.csv$")

# ʹ��lapply��ȡ�����ļ�����������洢���б���
data_list <- lapply(files, read_csv)

# ʹ��do.call��rbind�ϲ��������ݿ�
combined_data <- do.call(rbind, data_list)

# ����ϲ����data.frame
print(combined_data)

#������
# �����뱣��Ϊһ�� .R �ļ�������Ϊ merge_csv_files.R

# �����Ҫ�Ŀ�
library(readr)

# �������в�����ȡ·��
args <- commandArgs(trailingOnly = TRUE)
path <- args[1]

# ���ù���Ŀ¼
setwd(path)

# ��ȡ��ǰ����Ŀ¼�µ�����CSV�ļ�
files <- list.files(pattern = "\\.csv$")

# ʹ��lapply��ȡ�����ļ�����������洢���б���
data_list <- lapply(files, read_csv)

# ʹ��do.call��rbind�ϲ��������ݿ�
combined_data <- do.call(rbind, data_list)

# ����ϲ����data.frame
print(combined_data)

#Ҫ��������ű����������������R�����ݽű�·�����������
#Rscript merge_csv_files.R "D:/assignment_idaccuracy/Aminer"