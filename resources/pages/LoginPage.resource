*** Settings ***
Documentation            Açôes e elementos da pagina login

Library        Browser

***Keywords***

Submit login form 
    [Arguments]       ${user}

    Fill Text    css=input[placeholder$=mail]        ${user}[email]
    Fill Text    css=input[placeholder=Senha]        ${user}[password]

    Click        css=button >>text=Entrar
    # Click        xpath=//button[text()="Entrar"]

# Notice should be
#     [Arguments]        ${expectd_text}

#     ${element}        Set Variable        css=.notice p    

#     Wait For Elements State        ${element}
#     ...    visible        5
    
#     Get Text     ${element}        equal    ${expectd_text}

 