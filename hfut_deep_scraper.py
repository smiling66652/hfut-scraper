# -*- coding: utf-8 -*-
"""
合肥工业大学 - 深度检索比赛和活动信息
"""
import requests
from bs4 import BeautifulSoup
import json
import re
from urllib.parse import urljoin, urlparse
import sys
import io
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8')
import urllib3
urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)

HEADERS = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36',
    'Accept': 'text/html,application/xhtml+xml',
}

BASE_URL = 'https://www.hfut.edu.cn'

def get_page(url, timeout=15):
    try:
        r = requests.get(url, headers=HEADERS, timeout=timeout, verify=False)
        r.encoding = 'utf-8'
        return r.text
    except Exception as e:
        return None

def parse_detail_links(html, base_url, keywords):
    """从列表页解析详情页链接"""
    results = []
    if not html:
        return results
    soup = BeautifulSoup(html, 'html.parser')
    
    # 常见列表模式
    for item in soup.find_all(['li', 'div', 'tr'], class_=re.compile(r'news|item|list|article', re.I)):
        for a in item.find_all('a', href=True):
            text = a.get_text(strip=True)
            href = a['href']
            full_url = urljoin(base_url, href)
            for kw in keywords:
                if kw in text and full_url.startswith('http'):
                    results.append({'url': full_url, 'title': text, 'source': base_url})
                    break
    return results

def search_in_page(html, base_url, keywords):
    """在页面中搜索包含关键词的链接"""
    results = []
    if not html:
        return results
    soup = BeautifulSoup(html, 'html.parser')
    
    for a in soup.find_all('a', href=True):
        text = a.get_text(strip=True)
        href = a['href']
        full_url = urljoin(base_url, href)
        
        # 过滤条件
        if not full_url.startswith('http'):
            continue
        if not text or len(text) < 4:
            continue
            
        for kw in keywords:
            if kw in text:
                results.append({'url': full_url, 'title': text, 'keyword': kw, 'source': base_url})
                break
    return results

def get_page_date(item_text):
    """从标题中提取日期"""
    match = re.search(r'20\d{2}[./]\d{1,2}[./]\d{1,2}', item_text)
    if match:
        return match.group()
    return ''

def main():
    print("=" * 70)
    print("合肥工业大学 - 比赛/活动深度检索")
    print("=" * 70)
    
    # 关键词
    competition_keywords = ['比赛', '竞赛', '大赛', '创新', '创业', '挑战', '选拔', '征集']
    activity_keywords = ['活动', '报名', '通知', '公告', '培训', '工作坊', '宣讲', '讲座']
    
    all_results = []
    seen_urls = set()
    
    # ===== 一、校级通知门户 =====
    print("\n[1] 检索校级通知公告...")
    school_notices = [
        ('通知公告', 'https://www.hfut.edu.cn/tzgg.htm'),
        ('学术动态', 'https://www.hfut.edu.cn/xsdt.htm'),
        ('教务教学', 'https://jwc.hfut.edu.cn/'),
        ('科研通知', 'https://gfzby.hfut.edu.cn/'),
    ]
    
    for name, url in school_notices:
        print(f"  检索 {name}: {url}")
        html = get_page(url)
        if html:
            results = search_in_page(html, url, competition_keywords + activity_keywords)
            for r in results:
                if r['url'] not in seen_urls and 'hfut' in r['url']:
                    seen_urls.add(r['url'])
                    all_results.append(r)
            print(f"    找到 {len(results)} 条相关内容")
    
    # ===== 二、学生竞赛/创新创业 =====
    print("\n[2] 检索学生竞赛与创新创业栏目...")
    student_sections = [
        ('创新创业', 'https://cxcy.hfut.edu.cn/'),
        ('团委', 'https://tw.hfut.edu.cn/'),
        ('学生处', 'https://xsc.hfut.edu.cn/'),
        ('教务处竞赛', 'https://jwc.hfut.edu.cn/xsjzpx.htm'),
    ]
    
    for name, url in student_sections:
        print(f"  检索 {name}...")
        html = get_page(url)
        if html:
            results = search_in_page(html, url, competition_keywords + activity_keywords)
            for r in results:
                if r['url'] not in seen_urls and 'hfut' in r['url']:
                    seen_urls.add(r['url'])
                    all_results.append(r)
            print(f"    找到 {len(results)} 条")
    
    # ===== 三、各学院通知 =====
    print("\n[3] 检索各学院通知...")
    colleges = [
        ('机械工程学院', 'https://jxxy.hfut.edu.cn/'),
        ('材料科学与工程学院', 'https://clxy.hfut.edu.cn/'),
        ('电气与自动化工程学院', 'https://dqxy.hfut.edu.cn/'),
        ('计算机与信息学院', 'https://jsjx.hfut.edu.cn/'),
        ('土木与水利工程学院', 'https://tmxy.hfut.edu.cn/'),
        ('化学与化工学院', 'https://chemy.hfut.edu.cn/'),
        ('管理学院', 'https://glxy.hfut.edu.cn/'),
        ('经济学院', 'https://jjxy.hfut.edu.cn/'),
        ('外国语学院', 'https://wgyxy.hfut.edu.cn/'),
        ('建筑与艺术学院', 'https://jzxy.hfut.edu.cn/'),
        ('仪器科学与光电工程学院', 'https://ysxy.hfut.edu.cn/'),
        ('汽车与交通工程学院', 'https://qcxy.hfut.edu.cn/'),
    ]
    
    for name, url in colleges:
        print(f"  检索 {name}...")
        html = get_page(url)
        if html:
            results = search_in_page(html, url, competition_keywords + ['赛', '项目申报', '招募'])
            for r in results:
                if r['url'] not in seen_urls and 'hfut' in r['url']:
                    seen_urls.add(r['url'])
                    all_results.append(r)
            print(f"    找到 {len(results)} 条")
    
    # ===== 四、深度访问重点页面 =====
    print("\n[4] 深度访问重点页面...")
    key_pages = [
        'https://cxcy.hfut.edu.cn/tzgg.htm',
        'https://cxcy.hfut.edu.cn/xscy.htm',
        'https://tw.hfut.edu.cn/tztg.htm',
        'https://tw.hfut.edu.cn/xsjl.htm',
        'https://jwc.hfut.edu.cn/xsjzpx.htm',
        'https://jwc.hfut.edu.cn/tzgg.htm',
    ]
    
    for url in key_pages:
        print(f"  访问 {url.split('/')[-1]}...")
        html = get_page(url)
        if html:
            results = search_in_page(html, url, competition_keywords)
            for r in results:
                if r['url'] not in seen_urls:
                    seen_urls.add(r['url'])
                    all_results.append(r)
            print(f"    找到 {len(results)} 条")
    
    # ===== 五、输出结果 =====
    print("\n" + "=" * 70)
    print(f"检索结果汇总 (共 {len(all_results)} 条)")
    print("=" * 70)
    
    # 按关键词分类
    comp_results = [r for r in all_results if any(kw in r.get('keyword', '') or kw in r.get('title', '') 
                  for kw in ['比赛', '竞赛', '大赛', '创新', '创业', '挑战'])]
    act_results = [r for r in all_results if r not in comp_results]
    
    print(f"\n>>> 竞赛类 ({len(comp_results)} 条) <<<")
    for i, r in enumerate(comp_results, 1):
        print(f"  {i}. {r['title'][:55]}")
        print(f"     {r['url']}")
    
    print(f"\n>>> 活动通知类 ({len(act_results)} 条) <<<")
    for i, r in enumerate(act_results, 1):
        print(f"  {i}. {r['title'][:55]}")
        print(f"     {r['url']}")
    
    # 保存JSON
    output = {
        'total': len(all_results),
        'competitions': comp_results,
        'activities': act_results
    }
    with open('d:/杂物间/hfut_activities.json', 'w', encoding='utf-8') as f:
        json.dump(output, f, ensure_ascii=False, indent=2)
    
    print(f"\n[OK] 详细结果已保存到 d:/杂物间/hfut_activities.json")
    
    # 额外输出可访问链接
    print("\n" + "=" * 70)
    print("可直接访问的链接汇总:")
    print("=" * 70)
    for r in all_results[:30]:
        print(f"  {r['url']}")

if __name__ == '__main__':
    main()
