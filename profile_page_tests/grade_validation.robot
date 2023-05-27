*** Settings ***
Documentation   Average grade validation on profile page.
...             Validates that the grade is displayed and is above zero.
Library         String
Resource         ../resources/common.resource
Suite Setup     Open Browser On Page Under Test
Suite Teardown  Close Browser

*** Variables ***
${GRADE_XPATH}   /html[1]/body[1]/div[1]/div[1]/div[1]/div[4]/div[2]/div[1]/div[1]/div[2]/span[1]

*** Test Cases ***
Grade Is Visible
    Get Grade
    Grade Should Be Visible

Grade Is Above Zero
    Get Grade
    Get First Grade Digit
    First Grade Digit Should Be Positive

*** Keywords ***
Get Grade
    ${GRADE} =   Get WebElement   xpath: ${GRADE_XPATH}
    Set Test Variable   ${GRADE}

Grade Should Be Visible
    Element Should Be Visible   ${GRADE}

Get First Grade Digit
    ${VALUE} =   Get Element Attribute   ${GRADE}   innerHTML
    ${NUM} =   Get Substring   ${VALUE}   0   1
    ${FIRST_DIGIT} =   Convert To Integer   ${NUM}
    Set Test Variable   ${FIRST_DIGIT}

First Grade Digit Should Be Positive
    Should Be True   ${FIRST_DIGIT} > 0