#-*- coding: utf-8 -*-
from selenium import webdriver
from bs4 import BeautifulSoup
from time import sleep
import requests
import json
import re

header = {'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36'}
d = webdriver.Chrome('../downloads/chromedriver')
d.implicitly_wait(2)

# 로그인
d.get('https://member.melon.com/muid/web/login/login_inform.htm')
d.find_element_by_name('id').send_keys('#######')
d.find_element_by_name('pwd').send_keys('######')
d.find_element_by_xpath('//*[@id="btnLogin"]/span').click()

for i in range(15, 19):
    
    for j in range(1, 13):
        result = list()
        
        searchDate = '20' + str(i).zfill(2) + str(j).zfill(2)
        print(searchDate)
        print(isinstance(searchDate, str))
        try:
            d.get('https://www.melon.com/mymusic/top/mymusictopmanysong_listPaging.htm?startIndex=1&pageSize=50&memberKey=13192885&searchDate='+ searchDate)
        
        except:
            print("seachDate cannot be found")
            pass
        
        song_ids = d.find_elements_by_xpath('//*[@id="frm"]/div/table/tbody/tr/td[3]/div/div/a[1]')
        song_ids = [re.sub('[^0-9]', '', song_id.get_attribute("href")) for song_id in song_ids]
        
        ranks = d.find_elements_by_xpath('//*[@id="frm"]/div/table/tbody/tr/td[2]/div')
        
        # song_detail
        for rank, song_id in zip(ranks, song_ids):
            sleep(1)
            req = requests.get('http://www.melon.com/song/detail.htm?songId=' + song_id, headers=header)
            html = req.text
            soup = BeautifulSoup(html, "html.parser")
            
            title = soup.find(attrs={"class": "song_name"}).text.replace('곡명', '')
            
            artist = soup.find(attrs={"class": "artist_name"}).text
            
            genre = soup.select('#downloadfrm > div > div > div.entry > div.meta > dl > dd')[2].text
            
            title = re.sub('^\s*|\s+$', '', title)
            
            result.append({
                          'rank': rank,
                          'song_id': song_id,
                          'title': title,
                          'artist': artist,
                          'genre': genre
                          })
                          
            print(rank.text, "\t", song_id, "\t", title,"\t",artist,"\t",genre)
    
        # json
        with open('./data/mymusic'+ searchDate + '.json', 'w', encoding='utf-8') as f:
            j = json.dumps(result)
            f.write(j)
