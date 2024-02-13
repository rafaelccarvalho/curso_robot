*** Settings ***
Documentation        Ações de elementos do componente d enotificações

Library        Browser

*** Keywords ***
Notice should be
    [Arguments]    ${expect_tex}

    ${element}        Set Variable        css=.notice p 
           
    Wait For Elements State    ${element}         visible        5
    Get Text                   ${element}         equal          ${expect_tex}