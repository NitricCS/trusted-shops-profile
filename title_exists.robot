*** Settings ***
Documentation   This file contains a test to assert the page title exists
Resource        reusable.resource

*** Test Cases ***
Title Exists
    Open Browser On Page Under Test
    ${TITLE} =   Get Title
    Should Not Be Empty   ${TITLE}
    [Teardown]    Close Browser