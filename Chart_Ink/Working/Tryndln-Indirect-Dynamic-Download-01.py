import os
import time

from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.common.by import By

# Set up Chrome options to specify the download directory
download_dir = os.path.abspath("Output")
os.makedirs(download_dir, exist_ok=True)
chrome_options = webdriver.ChromeOptions()
prefs = {'download.default_directory': download_dir}
chrome_options.add_experimental_option('prefs', prefs)

# Initialize WebDriver
driver = webdriver.Chrome(service=Service(), options=chrome_options)

try:
    # 1. Open the website
    driver.get('https://trendlyne.com/login/')  # Adjust if login is needed

    # 2. Perform login if required
    # username_input = driver.find_element(By.ID, 'username')
    # password_input = driver.find_element(By.ID, 'password')
    # username_input.send_keys('your_username')
    # password_input.send_keys('your_password')
    # login_button = driver.find_element(By.ID, 'login_button')
    # login_button.click()
    # time.sleep(5)  # Wait for login to complete

    # 3. Navigate to the download page
    driver.get('https://trendlyne.com/page-with-download-link/')  # Replace with actual page URL

    # 4. Click the download button
    download_button = driver.find_element(By.XPATH,
                                          '//button[contains(text(), "Download")]')  # Adjust selector as needed
    download_button.click()

    # 5. Wait for download to finish (better to check file system in production)
    time.sleep(10)
finally:
    driver.quit()
