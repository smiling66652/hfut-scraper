# -*- coding: utf-8 -*-
"""
合肥工业大学官网比赛/活动信息检索
"""
import requests
from bs4 import BeautifulSoup
import re
import json
from urllib.parse import urljoin
import sys
import io
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8')

# 设置请求头
HEADERS = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
    'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8',
    'Accept-Language': 'zh-CN,zh;q=0.9,en;q=0.8',
}

BASE_URL = 'https://www.hfut.edu.cn'

def get_page(url, timeout=10):
    """获取网页内容"""
    try:
        response = requests.get(url, headers=HEADERS, timeout=timeout, verify=False)
        response.encoding = 'utf-8'
        return response.text
    except Exception as e:
        print(f"  获取失败: {url} - {e}")
        return None

def extract_links(html, base_url):
    """提取页面中所有链接"""
    if not html:
        return []
    soup = BeautifulSoup(html, 'html.parser')
    links = []
    for a in soup.find_all('a', href=True):
        href = a['href']
        text = a.get_text(strip=True)
        full_url = urljoin(base_url, href)
        if full_url.startswith('http'):
            links.append({'url': full_url, 'text': text})
    return links

def search_keyword_links(html, keywords, base_url):
    """搜索包含关键词的链接"""
    if not html:
        return []
    soup = BeautifulSoup(html, 'html.parser')
    results = []
    for a in soup.find_all('a', href=True):
        href = a['href']
        text = a.get_text(strip=True)
        full_url = urljoin(base_url, href)
        for kw in keywords:
            if kw in text or kw in href:
                if full_url.startswith('http'):
                    results.append({'url': full_url, 'text': text, 'keyword': kw})
    return results

def parse_list_page(html, base_url):
    """解析列表页面，提取文章条目"""
    if not html:
        return []
    soup = BeautifulSoup(html, 'html.parser')
    items = []
    # 常见列表容器
    for item in soup.select('.news-list li, .article-list li, .list-item, .news-item, ul li a, .container li a'):
        a = item if item.name == 'a' else item.find('a')
        if a and a.get('href'):
            href = a['href']
            text = a.get_text(strip=True)
            full_url = urljoin(base_url, href)
            if text and full_url.startswith('http'):
                items.append({'url': full_url, 'title': text})
    return items

def main():
    print("=" * 60)
    print("合肥工业大学官网 - 比赛/活动信息检索")
    print("=" * 60)
    
    # 关键词列表
    keywords = ['比赛', '竞赛', '活动', '通知', '公告', '创新', '创业', '大赛', '报名', '选拔']
    
    # 1. 访问首页
    print("\n[1] 访问官网首页...")
    homepage = get_page(BASE_URL)
    if homepage:
        print("  [OK] 首页获取成功")
        
        # 搜索首页中的相关链接
        relevant = search_keyword_links(homepage, keywords, BASE_URL)
        print(f"\n  首页中发现 {len(relevant)} 条相关内容:")
        for i, r in enumerate(relevant[:20], 1):
            print(f"    {i}. {r['text'][:40]} -> {r['url'][:60]}")
    
    # 2. 常见栏目URL
    print("\n[2] 尝试访问常见栏目...")
    sections = [
        '/tzgg.htm',           # 通知公告
        '/news.htm',           # 新闻中心
        '/jxdt.htm',           # 教学动态
        '/xshhd.htm',          # 学生/社团活动
        '/cxcy.htm',           # 创新创业
        '/jsjx.htm',           # 计算机学院
        '/gkml.htm',           # 公开目录
    ]
    
    all_results = []
    
    for section in sections:
        url = BASE_URL + section
        print(f"\n  访问: {section}...")
        html = get_page(url)
        if html:
            print(f"  ✓ 获取成功")
            
            # 搜索列表中的相关内容
            results = search_keyword_links(html, keywords, url)
            if results:
                print(f"    发现 {len(results)} 条:")
                for r in results[:5]:
                    all_results.append(r)
                    print(f"    - {r['text'][:50]}")
            
            # 解析新闻列表
            items = parse_list_page(html, url)
            if items:
                print(f"    列表项 {len(items)} 条")
    
    # 3. 深度搜索新闻页面
    print("\n[3] 深度搜索新闻栏目...")
    news_urls = [
        '/news.htm',
        '/tzgg.htm', 
        '/jxky.htm',   # 教务科研
        '/xsxx.htm',   # 学生信息
    ]
    
    for news_url in news_urls:
        url = BASE_URL + news_url
        html = get_page(url)
        if html:
            soup = BeautifulSoup(html, 'html.parser')
            # 查找更多链接
            for a in soup.find_all('a', href=True):
                href = a['href']
                text = a.get_text(strip=True)
                full_url = urljoin(url, href)
                for kw in ['比赛', '竞赛', '大赛', '创新创业', '活动通知']:
                    if kw in text:
                        if {'url': full_url, 'title': text, 'source': news_url} not in all_results:
                            all_results.append({'url': full_url, 'title': text, 'source': news_url})
    
    # 去重
    seen = set()
    unique_results = []
    for r in all_results:
        if r['url'] not in seen:
            seen.add(r['url'])
            unique_results.append(r)
    
    print(f"\n[4] 搜索结果汇总 (共 {len(unique_results)} 条)")
    print("-" * 60)
    
    for i, r in enumerate(unique_results, 1):
        title = r.get('title', r.get('text', ''))[:50]
        source = r.get('source', '')[:30]
        print(f"{i}. {title}")
        print(f"   URL: {r['url'][:70]}")
        if source:
            print(f"   来源: {source}")
    
    # 保存结果
    with open('d:/杂物间/hfut_activities.json', 'w', encoding='utf-8') as f:
        json.dump(unique_results, f, ensure_ascii=False, indent=2)
    print(f"\n✓ 结果已保存到 d:/杂物间/hfut_activities.json")

if __name__ == '__main__':
    import urllib3
    urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)
    main()
