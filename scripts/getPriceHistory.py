import argparse
# Generated by Selenium IDE
import pytest
import time
import json
import os
import shutil
import getpass
import argparse
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.action_chains import ActionChains
from selenium.webdriver.support import expected_conditions
from selenium.webdriver.support.wait import WebDriverWait
from selenium.webdriver.common.keys import Keys

# global variables
data_dir = None

class TestTest():
    def setup_method(self, method):
        self.driver = webdriver.Chrome()
        self.driver.get("https://steamdb.info/app/582010")
        time.sleep(10)
        self.driver.implicitly_wait(5)
        self.driver.set_window_size(1080, 824)
        self.driver.find_element(
            By.CSS_SELECTOR, ".dropdown > .btn").click()  # Set region
        self.driver.find_element(By.LINK_TEXT, "Chinese Yuan Renminbi").click()
        self.current_user = getpass.getuser()  # Get current user's name
        self.download_path = 'C:\\Users\\'+self.current_user + \
            '\\Downloads\\'  # Set default download path of Chrome
        self.vars = {}

    def teardown_method(self, method):
        self.driver.quit()

    def test_test(self, appid):
        try:
            self.driver.get("https://steamdb.info/app/"+appid+"/")
            self.driver.execute_script("window.scrollTo(0,2000)")
            self.driver.find_element(
                By.CSS_SELECTOR, ".highcharts-button-symbol").click()
            self.driver.find_element(
                By.CSS_SELECTOR, ".highcharts-menu-item:nth-child(1)").click()
            print('price-history-for-'+appid+'.csv')
            # Wait file to be in default download path
            origin=appid
            if len(appid)==7:
                appid=appid[0:6]
            while (not os.path.exists(self.download_path+'price-history-for-'+appid+'.csv')):
                pass
            shutil.move(self.download_path+'price-history-for-'+appid+'.csv',
                        'docs\\price-history\\price-history-for-'+origin+'.csv')  # Move file to the project's path
        except Exception as e:
            print(e)
            # Save appids whose price cannot be downloaded
            open(data_dir+"\\no-price-history\\"+appid, "w")


if __name__ == '__main__':
    test = TestTest()
    test.setup_method(None)
    parser=argparse.ArgumentParser()
    parser.add_argument('--file')
    ns=parser.parse_args()
    f = open(ns.file)
    for appid in f:
        appid = appid.split()[0]
        if(os.path.exists(data_dir+'\\price-history\\price-history-for-'+appid+'.csv') or os.path.exists(data_dir+'\\no-price-history\\'+appid)):
            print("skip "+appid)
            continue
        else:
            test.test_test(appid)
    test.teardown_method(None)
