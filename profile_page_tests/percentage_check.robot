*** Settings ***
Documentation   Test to verify that percentage sum
...             is less than or equal to 100.
Library         Collections
Resource         ../resources/common.resource
Suite Setup     Open Browser On Page Under Test
Suite Teardown  Close Browser

*** Variables ***
${PERCENTAGE_XPATH} =   //div[h3[contains(@class,"Heading-")]]//div[span[text()='%']]

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