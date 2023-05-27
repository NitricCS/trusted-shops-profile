*** Settings ***
Documentation    Test to verify that page title exists.
Resource         reusable.resource
Suite Setup      Open Browser On Page Under Test
Suite Teardown   Close Browser

*** Test Cases ***
Title Exists
    ${TITLE} =   Get Title
    Should Not Be Empty   ${TITLE}