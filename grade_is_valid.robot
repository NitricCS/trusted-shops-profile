*** Settings ***
Documentation   This file contains tests to validate the grade
Library         String
Resource        reusable.resource
Suite Setup     Open Browser On Page Under Test
Suite Teardown  Close Browser

*** Variables ***
${XPATH}   /html[1]/body[1]/div[1]/div[1]/div[1]/div[4]/div[2]/div[1]/div[1]/div[2]/span[1]

*** Test Cases ***
Grade Is Visible
    ${GRADE} =   Get WebElement   xpath: ${XPATH}
    Element Should Be Visible   ${GRADE}

Grade Is Above Zero
    ${GRADE_VALUE} =   Get First Grade Digit
    Should Be Positive   ${GRADE_VALUE}

*** Keywords ***
Get First Grade Digit
    ${VALUE} =   Get Element Attribute   xpath: ${XPATH}   innerHTML
    ${DIGIT} =   Get Substring   ${VALUE}   0   1
    ${N_DIGIT} =   Convert To Integer   ${DIGIT}
    RETURN   ${N_DIGIT}

Should Be Positive
    [Arguments]   ${value}
    Should Be True   ${value} > 0