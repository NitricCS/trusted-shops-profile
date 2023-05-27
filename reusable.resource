*** Settings ***
Documentation   This file contains basic keywords and reusable variables for the tests.
Library         SeleniumLibrary   run_on_failure=None

*** Variables ***
${BROWSER}  Chrome
${DOMAIN}   www.trustedshops.de/bewertung
${URL}      https://${DOMAIN}/info_X77B11C1B8A5ABA16DDEC0C30E7996C21.html
#${URL}      https://${DOMAIN}/info_X5DD89D3C0A05113C1366DA02591C57DB.html
${WIDTH}    1600
${HEIGHT}   900
${COOKIE_WINDOW_XPATH}   //*[contains(text(), "Akzeptieren")]

*** Keywords ***
Open Browser On Page Under Test
    Open Browser   ${URL}   ${BROWSER}
    Set Window Size   ${WIDTH}   ${HEIGHT}
    Set Selenium Implicit Wait   5
    Close Cookie Window

Close Cookie Window
    Delete All Cookies
    Wait Until Page Contains Element   xpath: ${COOKIE_WINDOW_XPATH}
    Click Button   ${COOKIE_WINDOW_XPATH}