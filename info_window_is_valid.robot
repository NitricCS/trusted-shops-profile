*** Settings ***
Documentation   Test the information window
Library         String
Library         Collections
Resource        reusable.resource
Suite Setup     Open Browser On Page Under Test
Suite Teardown  Close Browser

*** Variables ***
${LINK_TEXT}     Wie berechnet sich die Note?
${MODAL_XPATH}   /html[1]/body[1]/div[1]/div[1]/div[1]/div[4]/div[4]
${NAME_XPATH}    /html[1]/body[1]/div[1]/div[1]/div[1]/div[1]/div[2]/h1[1]/span[1]
${HEADER_XPATH}  /html[1]/body[1]/div[1]/div[1]/div[1]/div[4]/div[4]/div[1]/span[1]
${TEXT_XPATH}    /html[1]/body[1]/div[1]/div[1]/div[1]/div[4]/div[4]/div[2]/div[1]/div[1]/span[1]
${GRADE_CALC_XPATH}   //pre[contains(text(),'Notenberechnung auf Basis der Sternevergabe')]

*** Test Cases ***
Modal Window Opens
    Click Element   link: ${LINK_TEXT}
    Modal Window Should Open

Info Is Relevant
    ${STORE} =   Get Store Name
    Header Should Be Relevant  ${STORE}
    Text Should Be Relevant   ${STORE}
    Page Should Contain Element   xpath: ${GRADE_CALC_XPATH}

*** Keywords ***
Modal Window Should Open
    Page Should Contain Element   xpath: ${MODAL_XPATH}

Header Should Be Relevant
    [Arguments]   ${store_name}
    ${HEADER} =   Get Element Attribute   xpath: ${HEADER_XPATH}   innerHTML
    Should Contain   ${HEADER}   ${store_name}

Text Should Be Relevant
    [Arguments]   ${store_name}
    ${TEXT} =   Get Element Attribute   xpath: ${TEXT_XPATH}   innerHTML
    Should Contain   ${TEXT}   ${store_name}

Get Store Name
    ${SPAN} =   Get Element Attribute   xpath: ${NAME_XPATH}   innerHTML
    ${S_SPAN} =   Split String   ${SPAN}   <
    ${NAME} =   Get From List   ${S_SPAN}   0
    RETURN   ${NAME}