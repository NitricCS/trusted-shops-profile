*** Settings ***
Documentation   Information popup validation.
...             Verifies that info popup opens by clicking the link
...             and that information in it is relevant.
...             Popup is relevant if:
...             1. It contains a text about the correct store.
...             2. It contains reference about grade calculation.
Resource         ../resources/common.resource
Suite Setup     Open Browser On Page Under Test
Suite Teardown  Close Browser

*** Variables ***
${LINK_TEXT}            Wie berechnet sich die Note?
${CLOSE_BUTTON_XPATH}   //span[contains(@class,"Modalstyles__CloseIcon")]
${POPUP_XPATH}          //div[@data-test="modal-dialogue"]
${STORE_XPATH}          //h1[contains(@class,"Heading-")]/span[1]
${HEADER_XPATH}         //span[contains(@class,"_ModalTitle-")]
${TEXT_XPATH}           //div[contains(@class,"Modalstyles__Children")]//span[1]
${GRADE_CALC_XPATH}     //pre[contains(text(),'Notenberechnung auf Basis der Sternevergabe')]

*** Test Cases ***
Popup Opens
    [Setup]      Open Info Popup
    Popup Should Open
    [Teardown]   Close Info Popup

Info Is Relevant
    [Setup]      Open Info Popup
    Get Store Name
    Header Should Contain Store
    Text Should Contain Store
    Page Should Contain Element   xpath: ${GRADE_CALC_XPATH}
    [Teardown]   Close Info Popup

*** Keywords ***
Open Info Popup
    Click Element   link: ${LINK_TEXT}

Close Info Popup
    Click Element   xpath: ${CLOSE_BUTTON_XPATH}

Popup Should Open
    Page Should Contain Element   xpath: ${POPUP_XPATH}

Get Store Name
    ${SPAN} =         Get Element Attribute   xpath: ${STORE_XPATH}   innerHTML
    ${STORE_NAME} =   Extract Store Name      ${SPAN}
    Set Test Variable   ${STORE_NAME}

Header Should Contain Store
    ${HEADER} =   Get Element Attribute   xpath: ${HEADER_XPATH}  innerHTML
    Should Contain   ${HEADER}   ${STORE_NAME}

Text Should Contain Store
    ${TEXT} =   Get Element Attribute   xpath: ${TEXT_XPATH}   innerHTML
    Should Contain   ${TEXT}   ${STORE_NAME}