*** Settings ***
Resource    common-resource.robot
Test Setup    Open Browser    ${URL}
Test Teardown    Close Browser

*** Variables ***
${SEARCH RESULT COUNT POSTFIX}=    tuotetta

*** Test Cases ***
Search Returns Items
    Search With   ${SEARCH TERM WITH RESULTS}
    Verify Search Results Were Found    ${SEARCH TERM WITH RESULTS}

Search Returns Error Message When No Items Found
    Search With    abcdefghijklm
    Verify No Search Results Error Message Displayed    abcdefghijklm

*** Keywords ***
Verify Search Results Were Found
	[Arguments]    ${searchterm}
    ${search results}=    Get Text    css=h1.title
    Should Match    ${search results}    ${searchterm} * ${SEARCH RESULT COUNT POSTFIX}

Verify No Search Results Error Message Displayed
   [Arguments]    ${searchterm}
   ${error message}=    Get Text    css=.flash.warning
   Should Match    ${error message}    Hakusanalla "${searchterm}" ei löytynyt hakutuloksia.