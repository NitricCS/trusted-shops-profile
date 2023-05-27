*** Settings ***
Documentation   Test the 2-star filter
Library         Collections
Library         ProfileTestLibrary.py
Resource        reusable.resource
Suite Setup     Open Browser On Page Under Test
Suite Teardown  Close Browser

*** Variables ***
${STARS_UNDER_TEST}   ${2}
${2STAR_XPATH}   //a[contains(@href,"?stars=${STARS_UNDER_TEST}")]
${REVIEW_RATING_XPATH}   //body/div/div/div[1]/div[5]/div/*/div[div[starts-with(@class,"Starsstyles__")] and not(a)]/div[1]
${RIGHT_ARROW_LINK}      //div[@id='pagination']/*/span[contains(@class,"icon-arrow-chevron-right")]/parent::*
${PATTERN}    Iconstyles__Icon-sc-hltmf-0

*** Test Cases ***
2 Star Filter Works
    Click Element   xpath: ${2STAR_XPATH}
    ${RATINGS_LIST} =   Get Ratings
    Log   ${RATINGS_LIST}
    Ratings Should Have Stars   ${RATINGS_LIST}   ${STARS_UNDER_TEST}

*** Keywords ***
Navigate To Next Page
    Scroll Element Into View   xpath: ${RIGHT_ARROW_LINK}
    Click Element   xpath: ${RIGHT_ARROW_LINK}

Get Ratings
    ${RATINGS_LIST} =   Create List
    Add New Ratings   ${RATINGS_LIST}
    ${ANOTHER_PAGE} =   Run Keyword And Return Status   There Is Another Page
    WHILE   ${ANOTHER_PAGE}
        Navigate To Next Page
        Add New Ratings   ${RATINGS_LIST}
        ${ANOTHER_PAGE} =   Run Keyword And Return Status   There Is Another Page
    END
    RETURN   ${RATINGS_LIST}

Add New Ratings
    [Arguments]   ${ratings_list}
    ${PAGE_RATINGS} =   Get Ratings On Page
    Append To List   ${ratings_list}   ${PAGE_RATINGS}

Get Ratings On Page
    ${PAGE_STARS} =   Create List
    @{PAGE_RATINGS} =   Get WebElements   xpath: ${REVIEW_RATING_XPATH}
    FOR  ${RATING}  IN  @{PAGE_RATINGS}
        ${STARS} =   Get Element Attribute   ${RATING}   innerHTML
        Append To List   ${PAGE_STARS}   ${STARS}
    END
    RETURN   ${PAGE_STARS}

There Is Another Page
    Page Should Contain Element   xpath: ${RIGHT_ARROW_LINK}