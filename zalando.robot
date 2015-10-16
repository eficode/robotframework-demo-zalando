*** Settings ***
Library    Selenium2Library
Library    String
Test Setup    Open Browser    ${URL}
Test Teardown    Close Browser

*** Variables ***
${URL}=    https://www.zalando.fi/
${SEARCH TERM WITH RESULTS}=    Levis 501
${SHOPPING CART TITLE}=   Ostoskori
${ADDED TO SHOPPING CART POSITIVE FEEDBACK MESSAGE}=    Lisätty ostoskoriin
${SEARCH RESULT COUNT POSTFIX}=    tuotetta

*** Test Cases ***
Search Returns Items
    Search With   ${SEARCH TERM WITH RESULTS}
    Verify Search Results Were Found    ${SEARCH TERM WITH RESULTS}

Search Returns Error Message When No Items Found
    Search With    abcdefghijklm
    Verify No Search Results Error Message Displayed    abcdefghijklm

Adding Item To Shopping Cart Displays Price Correctly
    Search With    ${SEARCH TERM WITH RESULTS}
    Click Random Search Result
    Add Random Item To Shopping Cart
    ${article price}=    Get Text    articlePrice
    Open Shopping Cart
    Verify Shopping Cart Item Price Correctly    ${article price}

*** Keywords ***
Verify Shopping Cart Item Price Correctly
   [Arguments]    ${article price}
   Element Should Contain    css=strong.grandTotal    ${article price}

Open Shopping Cart
    Click Link    css=.cart.naviLink
    Element Should Contain    css=h1.title    ${SHOPPING CART TITLE}

Add Random Item To Shopping Cart
    Click Random Size
    Click Add To Shopping Cart Button
    Wait Until Page Contains    ${ADDED TO SHOPPING CART POSITIVE FEEDBACK MESSAGE}

Click Add To Shopping Cart Button
    Click Button    ajaxAddToCartBtn

Search With
    [Arguments]    ${searchterm}
    Type In Search Word     ${searchterm}
    Click Search Button

Type In Search Word
    [Arguments]    ${searchterm}
    Input Text    css=[name="q"]    ${searchterm}

Click Search Button
    Click Element    searchButtonTopSubmit

Verify Search Results Were Found
	[Arguments]    ${searchterm}
    ${search results}=    Get Text    css=h1.title
    Should Match    ${search results}    ${searchterm} * ${SEARCH RESULT COUNT POSTFIX}

Verify No Search Results Error Message Displayed
   [Arguments]    ${searchterm}
   ${error message}=    Get Text    css=.flash.warning
   Should Match    ${error message}    Hakusanalla "${searchterm}" ei löytynyt hakutuloksia.

Click Random Size
    Click Element    css=#sizeSelect span
    Click Random Element    //*[@id="listProductSizes"]//li[not(contains(@class, "unavailable"))]

Click Random Search Result
    Click Random Element    //ul[contains(@class, "catalogArticlesList")]//li    //img

Click Random Element
    [Arguments]    ${locator}    ${child locator}=
    ${matching count}=    Get Matching Xpath Count    ${locator}
    ${random matching count int}=   Convert To Integer    ${matching count}
    ${random matching index}=    Evaluate    random.randint(1, ${random matching count int})    random
    Click Element    xpath=(${locator})[${random matching index}]${child locator}