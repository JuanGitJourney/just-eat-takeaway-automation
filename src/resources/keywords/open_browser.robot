*** Settings ***
Documentation     Launching Firefox and navigating to the Just Eat Takeaway careers page with Robot Framework.
Library           SeleniumLibrary

*** Variables ***
${BROWSER}    Firefox
${URL}    https://careers.justeattakeaway.com/global/en/home

*** Keywords ***
Open Just Eat Takeaway Careers Page
    Create Webdriver    ${BROWSER}
    Go To    ${URL}
    Maximize Browser Window
    Delete All Cookies
