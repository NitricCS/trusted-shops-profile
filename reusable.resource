*** Settings ***
Documentation   This file contains basic keywords and reusable variables for the tests.
Library         SeleniumLibrary

*** Variables ***
${BROWSER}  Chrome
${DOMAIN}   www.trustedshops.de/bewertung
${URL}      https://${DOMAIN}/info_X77B11C1B8A5ABA16DDEC0C30E7996C21.html
${WIDTH}    1600
${HEIGHT}   1200

*** Keywords ***
Open Browser On Page Under Test
    Open Browser   ${URL}   ${BROWSER}
    Set Window Size   ${WIDTH}   ${HEIGHT}
    Set Selenium Implicit Wait   5
