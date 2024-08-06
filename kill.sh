#!/bin/bash

# # 获取进程名作为参数
# if [ -z "$1" ]; then
#   echo "Usage: $0 <process_name>"
#   exit 1
# fi

PROCESS_NAME=qemu

# 使用 pgrep 获取进程号
PID=$(pgrep $PROCESS_NAME)

# 检查是否找到进程号
if [ -z "$PID" ]; then
  echo "No process found with name: $PROCESS_NAME"
  exit 1
fi

# 使用 kill 终止进程
kill -9 $PID

# 检查 kill 命令是否成功
if [ $? -eq 0 ]; then
  echo "Process $PROCESS_NAME (PID: $PID) has been terminated."
else
  echo "Failed to terminate process $PROCESS_NAME (PID: $PID)."
  exit 1
fi