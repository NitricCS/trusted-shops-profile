*** Settings ***
Documentation   Average grade validation on profile page.
...             Validates that the grade is displayed and is above zero.
...             Validating the format of the grade
...             or any additional value checks
...             are out of scope of this test.
Library         String
Resource         ../resources/common.resource
Suite Setup     Open Browser On Page Under Test
Suite Teardown  Close Browser

*** Variables ***
${GRADE_XPATH}   /html[1]/body[1]/div[1]/div[1]/div[1]/div[4]/div[2]/div[1]/div[1]/div[2]/span[1]

*** Test Cases ***
Grade Is Visible
    Grade Should Be Visible
    Grade Should Not Be Empty

Grade Is Above Zero
    Get Grade Value
    Grade Value Should Be Positive

*** Keywords ***
Get Grade Value
    ${GRADE_VALUE} =   Get Element Attribute   xpath: ${GRADE_XPATH}   innerHTML
    Set Test Variable   ${GRADE_VALUE}

Grade Should Be Visible
    Element Should Be Visible   xpath: ${GRADE_XPATH}

Grade Should Not Be Empty
    Get Grade Value
    Should Not Be Empty   ${GRADE_VALUE}