#!/bin/bash

# 检查是否输入参数
if [ $# -eq 0 ]; then
    echo "请提供文件名作为参数"
    exit 1
fi

# 获取当前时间
current_date=$(date +"%Y-%m-%d")
current_datetime=$(date +"%Y-%m-%d %H:%M +0800")

# 创建文件名
filename="${current_date}-$1.md"

# 创建文件
touch "$filename"

# 写入文件内容
cat <<EOL > "$filename"
---
layout: post
title: $1
date: $current_datetime
categories: []
tags: []
toc: true
---
EOL

mv "$filename" _posts/

# 输出文件名
echo "已创建文件: $filename"