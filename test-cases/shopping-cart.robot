*** Settings ***
Resource    ..${/}resources${/}common-resource.robot

*** Variables ***
${SHOPPING CART TITLE}=   Ostoskori
${ADDED TO SHOPPING CART POSITIVE FEEDBACK MESSAGE}=    Lisätty ostoskoriin

*** Test Cases ***
Adding Items To Shopping Cart Displays Price Correctly
    [Template]    Adding Item To Shopping Cart Should Display It's Price Correctly
    ${SEARCH TERM WITH RESULTS}
    Adidas Superstar
    Converse Chuck Taylor
    Levis T-shirt

*** Keywords ***
Adding Item To Shopping Cart Should Display It's Price Correctly
    [Arguments]    ${search term}
    [Teardown]    Close Browser
    Open Browser    ${URL}
    Search With    ${search term}
    Click Random Search Result
    Add Random Item To Shopping Cart
    ${article price}=    Get Text    articlePrice
    Open Shopping Cart
    Verify Shopping Cart Item Price Is Displayed Correctly    ${article price}

Verify Shopping Cart Item Price Is Displayed Correctly
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