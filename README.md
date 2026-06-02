# 🕷️ hfut-scraper

> 合工大官网信息爬取工具集 — 比赛活动信息抓取、官网巡检、报告生成

![Python](https://img.shields.io/badge/python-3.8+-green.svg)
![License](https://img.shields.io/badge/license-MIT-blue.svg)
![GitHub](https://img.shields.io/badge/GitHub-smiling66652-orange.svg)

---

## ✨ 功能一览

| 脚本 | 功能 | 输出 |
|------|------|------|
| `hfut_scraper.py` | 基础版官网爬虫，抓取比赛/活动信息 | JSON + Markdown 报告 |
| `hfut_deep_scraper.py` | 深度爬虫，支持分页/动态加载 | JSON + 详细报告 |
| `md_to_docx.py` | Markdown 报告转 Word 文档 | `.docx` 文件 |
| `hfut_activities.json` | 历史抓取数据存档 | JSON 结构化数据 |

---

## 🚀 快速开始

### 1. 安装依赖

```bash
pip install requests beautifulsoup4 lxml python-docx
```

### 2. 运行爬虫

```bash
# 基础版
python hfut_scraper.py

# 深度版（推荐）
python hfut_deep_scraper.py
```

### 3. 生成 Word 报告

```bash
python md_to_docx.py 合肥工业大学比赛活动检索报告.md
# 输出：合肥工业大学比赛活动检索报告.docx
```

---

## 📖 详细使用

### `hfut_scraper.py` — 基础爬虫

**抓取目标**：
- 合工大官网新闻动态
- 教务处通知公告
- 学工部活动信息
- 团委比赛信息

**输出示例**：
```json
{
  "title": "关于举办第XX届XX比赛的通知",
  "url": "https://www.hfut.edu.cn/...",
  "date": "2026-06-01",
  "source": "教务处",
  "category": "比赛"
}
```

### `hfut_deep_scraper.py` — 深度爬虫

**增强功能**：
- 自动翻页，抓取全量信息
- 支持动态加载（Ajax 请求）
- 去重 + 增量更新
- 异常重试 + 断点续爬

**配置示例**：
```python
# 在脚本内修改
TARGET_URLS = [
    "https://www.hfut.edu.cn/tzgg.htm",
    "https://jwc.hfut.edu.cn/tzgg.htm",
    # 添加更多目标...
]
OUTPUT_DIR = "./output"
```

### `md_to_docx.py` — Markdown 转 Word

**功能**：
- 支持中文排版（宋体、标题层级）
- 自动生成目录
- 代码块高亮
- 表格样式优化

```bash
# 基本用法
python md_to_docx.py input.md

# 指定输出文件名
python md_to_docx.py input.md -o output.docx
```

---

## 📂 项目结构

```
hfut-scraper/
├── README.md                        # 本文件
├── LICENSE                         # MIT 许可证
├── hfut_scraper.py                # 基础爬虫
├── hfut_deep_scraper.py           # 深度爬虫
├── md_to_docx.py                  # Markdown → Word 转换
├── hfut_activities.json           # 历史数据存档
└── 合肥工业大学比赛活动检索报告.md  # 最新报告
```

---

## 🔧 配置说明

### 爬虫配置

在 `hfut_scraper.py` / `hfut_deep_scraper.py` 中修改：

```python
# 请求头（模拟浏览器）
HEADERS = {
    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) ..."
}

# 请求间隔（防止被封）
REQUEST_INTERVAL = 1  # 秒

# 超时设置
TIMEOUT = 10  # 秒
```

### 输出配置

```python
# JSON 输出路径
JSON_OUTPUT = "hfut_activities.json"

# Markdown 报告路径
MD_OUTPUT = "合肥工业大学比赛活动检索报告.md"

# Word 报告路径
DOCX_OUTPUT = "合肥工业大学比赛活动检索报告.docx"
```

---

## 📊 使用示例

### 示例 1：每日定时爬取（Windows 任务计划）

```bash
# 创建定时任务（每天 8:00 运行）
schtasks /create /sc daily /st 08:00 /tn "HFUT_Scraper" /tr "python D:/wb_misc/hfut_deep_scraper.py"
```

### 示例 2：结合 WorkBuddy 自动化

```python
# 在 WorkBuddy 中配置定时任务
# 每天自动爬取 → 生成报告 → 推送 QQ 邮箱

import subprocess
from datetime import datetime

def daily_crawl():
    print(f"[{datetime.now()}] 开始爬取...")
    subprocess.run(["python", "hfut_deep_scraper.py"])
    subprocess.run(["python", "md_to_docx.py", "合肥工业大学比赛活动检索报告.md"])
    print(f"[{datetime.now()}] 完成！")

if __name__ == "__main__":
    daily_crawl()
```

### 示例 3：数据分析与可视化

```python
import json
import matplotlib.pyplot as plt

with open("hfut_activities.json", "r", encoding="utf-8") as f:
    data = json.load(f)

# 按来源统计
sources = {}
for item in data:
    src = item.get("source", "未知")
    sources[src] = sources.get(src, 0) + 1

# 绘制柱状图
plt.bar(sources.keys(), sources.values())
plt.title("合工大信息来源分布")
plt.show()
```

---

## 🛡️ 注意事项

1. **遵守 `robots.txt`**：爬取前检查目标网站的爬虫协议
2. **控制频率**：建议间隔 ≥ 1 秒，避免对服务器造成压力
3. **仅用于学习**：爬取的数据仅用于个人学习研究，不得商用
4. **异常处理**：网络异常时自动重试 3 次，仍失败则记录日志

---

## 🐛 常见问题

### Q1：爬取失败（连接超时）？

```bash
# 检查网络连接
ping www.hfut.edu.cn

# 检查是否需要校园网 VPN
# 部分校内通知需要 VPN 才能访问
```

### Q2：生成 Word 文档乱码？

```bash
# 确保使用 UTF-8 编码
# 在 md_to_docx.py 中检查：
with open("input.md", "r", encoding="utf-8") as f:
    ...
```

### Q3：如何只爬取新增信息？

```python
# 在 hfut_deep_scraper.py 中启用增量模式
INCREMENTAL_MODE = True  # 只爬取数据库中没有的 URL
```

---

## 🔗 相关项目

- [hfut_info_monitor](https://github.com/smiling66652/hfut_info_monitor) — 合工大信息监控系统（基于本爬虫）
- [WorkBuddy](https://workbuddy.cn) — AI 助手工具

---

## 📄 许可证

MIT License — 可自由使用、修改、分发。

---

## 🙏 致谢

- [Requests](https://requests.readthedocs.io/) — HTTP 库
- [BeautifulSoup](https://www.crummy.com/software/BeautifulSoup/) — HTML 解析
- [python-docx](https://python-docx.readthedocs.io/) — Word 文档生成

---

## 📮 联系方式

- GitHub: [@smiling66652](https://github.com/smiling66652)
- Email: 2240678683@qq.com

---

<div align="center">

**🕷️ 如果这个项目对你有帮助，请给我一个 Star！**

</div>
