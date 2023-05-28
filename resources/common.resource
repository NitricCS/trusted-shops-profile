*** Settings ***
Documentation   Resource file with setup keywords and base variables
...             for Trusted Shops profile page testing.
Library         SeleniumLibrary   run_on_failure=None
Library         ProfileTestLibrary.py

*** Variables ***
${BROWSER}               Chrome
${DOMAIN}                www.trustedshops.de/bewertung
${URL}                   https://${DOMAIN}/info_X77B11C1B8A5ABA16DDEC0C30E7996C21.html
${WIDTH}                 1600
${HEIGHT}                1000
${COOKIE_WINDOW_XPATH}   //*[contains(text(), "Akzeptieren")]
${POPUP_LINK_TEXT}       Wie berechnet sich die Note?

*** Keywords ***
Open Browser On Page Under Test
    Open Browser   ${URL}   ${BROWSER}
    Set Window Size   ${WIDTH}   ${HEIGHT}
    Set Selenium Implicit Wait   5

Close Cookie Window
    Delete All Cookies
    Wait Until Page Contains Element   xpath: ${COOKIE_WINDOW_XPATH}   10
    Click Button   ${COOKIE_WINDOW_XPATH}