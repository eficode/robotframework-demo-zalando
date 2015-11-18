*** Settings ***
Library    Selenium2Library
Library    String

*** Variables ***
${URL}=    https://www.zalando.fi/
${SEARCH TERM WITH RESULTS}=    Levis 501
${ADDED TO SHOPPING CART POSITIVE FEEDBACK MESSAGE}=    Lisätty ostoskoriin
${SEARCH RESULT COUNT POSTFIX}=    tuotetta

*** Keywords ***
Search With
    [Arguments]    ${searchterm}
    Type In Search Word     ${searchterm}
    Click Search Button

Type In Search Word
    [Arguments]    ${searchterm}
    Input Text    css=[name="q"]    ${searchterm}

Click Search Button
    Click Element    searchButtonTopSubmit