#!/bin/bash

# Step 0: 删除 html 和 sphinx_src 文件夹
rm -rf docs/api/html
rm -rf docs/api/sphinx_src

# Step 1: 安装 Sphinx 和 sphinx_material（如果尚未安装）
pip show quairkit > /dev/null 2>&1 || pip install quairkit
pip show sphinx_immaterial > /dev/null 2>&1 || pip install sphinx_immaterial

# Step 2: 生成所有必要的 rst 和 conf.py 文件
python docs/update_quairkit_rst.py

# Step 3: 使用 Sphinx 构建 HTML 文档
sphinx-build -b html docs/sphinx_src docs/api

# Step 4: 打开生成的 HTML 文档
if command -v xdg-open > /dev/null; then
  xdg-open docs/api/index.html
elif command -v open > /dev/null; then
  open docs/api/index.html
elif command -v start > /dev/null; then
  start docs/api/index.html
else
  echo "Could not detect the web browser command to open the generated HTML file."
fi