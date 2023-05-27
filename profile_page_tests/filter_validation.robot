*** Settings ***
Documentation   Rating filter validation.
...             Checks if clicking on a star rating filters out
...             reviews with given number of stars.
Library         Collections
Resource         ../resources/common.resource
Suite Setup     Open Browser On Page Under Test
Suite Teardown  Close Browser

*** Variables ***
${STARS_UNDER_TEST}      ${2}
${FILTER_XPATH}          //a[contains(@href,"?stars=${STARS_UNDER_TEST}")]
${REVIEW_RATING_XPATH}   //body/div/div/div[1]/div[5]/div/*/div[div[starts-with(@class,"Starsstyles__")] and not(a)]/div[1]
${RIGHT_ARROW_LINK}      //div[@id='pagination']/*[span[contains(@class,"icon-arrow-chevron-right")]]

*** Test Cases ***
Rating Filter
    [Setup]   Click Element     xpath: ${FILTER_XPATH}
    Get Ratings
    Ratings Should Have Stars   ${STARS_UNDER_TEST}

*** Keywords ***
Navigate To Next Page
    Scroll Element Into View   xpath: ${RIGHT_ARROW_LINK}
    Click Element              xpath: ${RIGHT_ARROW_LINK}

Get Ratings
    ${RATINGS_LIST} =   Create List
    Set Test Variable   ${RATINGS_LIST}
    Get Ratings On Page
    ${ANOTHER_PAGE} =   Run Keyword And Return Status   There Is Another Page
    WHILE   ${ANOTHER_PAGE}
        Navigate To Next Page
        Get Ratings On Page
        ${ANOTHER_PAGE} =   Run Keyword And Return Status   There Is Another Page
    END

Get Ratings On Page
    ${PAGE_RATINGS} =   Create List
    @{RATING_DIVS} =    Get WebElements   xpath: ${REVIEW_RATING_XPATH}
    FOR  ${DIV}  IN  @{RATING_DIVS}
        ${RATING} =   Get Element Attribute   ${DIV}   innerHTML
        Append To List   ${PAGE_RATINGS}   ${RATING}
    END
    Append To List   ${RATINGS_LIST}   ${PAGE_RATINGS}

There Is Another Page
    Page Should Contain Element   xpath: ${RIGHT_ARROW_LINK}