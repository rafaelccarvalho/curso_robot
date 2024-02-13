*** Settings ***
Documentation        Açôes e elementos do cabeçalho do mark85

Library        String
Library        Browser

*** Keywords ***

User should be logged in
    [Arguments]        ${name} 
    
    ${element}        Set Variable    css=header .right small

    Wait For Elements State            ${element}
    ...     visible        10
       
    Get Text       ${element}        equal    Olá, ${name}

Go to task form
     Click    css=.button-add   