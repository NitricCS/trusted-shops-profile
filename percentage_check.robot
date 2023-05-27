*** Settings ***
Documentation   Percentage validation test
Library         Collections
Library         ProfileTestLibrary.py
Resource        reusable.resource
Suite Setup     Open Browser On Page Under Test
Suite Teardown  Close Browser

*** Variables ***
${PERCENTAGE_XPATH} =   //body[1]/div[1]/div[1]/div[1]/div[4]/div[2]/div[2]/div[1]//div[span[text()='%']]

*** Test Cases ***
Percentage Sum Is Valid
    Get Percentages
    Should Not Be Empty   ${PERCENTAGES}   Percentage block not found on the page
    Percentage Sum Should Be Valid

*** Keywords ***
Get Percentages
    ${PERCENTAGES} =   Create List
    @{PERCENTAGE_DIVS} =   Get WebElements   xpath: ${PERCENTAGE_XPATH}
    FOR  ${DIV}  IN  @{PERCENTAGE_DIVS}
        ${PERCENTAGE} =   Get Element Attribute   ${DIV}   innerHTML
        Append To List   ${PERCENTAGES}   ${PERCENTAGE}
    END
    Set Test Variable   ${PERCENTAGES}