*** Settings ***
Resource    ..${/}resources${/}common-resource.robot
Test Setup    Open Browser    ${URL}
Test Teardown    Close Browser

*** Variables ***
${USERFIRSTNAME}=       Anne
${USERLASTNAME}=        Testi
${PASSWORD}=            password
${EMAIL}=               testi.anne@noreply.com

*** Test Cases ***
Fail Registration
    Click id          customerAccountBox
	Click Element     xpath=//*[@class="bold underlinedLink registerLink"]
	Fill id        registerFirstname       ${USERFIRSTNAME}
	Fill id        registerLastname        ${USERLASTNAME}
	Fill id        registerEmail           ${EMAIL}
	Fill id        registerPassword        ${PASSWORD}
	Fill id        registerPassword2       ${PASSWORD}
	Click Button      id=submitRegister
	Page Should Contain           Tämä on pakollinen kenttä
