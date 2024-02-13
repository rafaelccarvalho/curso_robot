*** Settings ***
Documentation            Cenarios de testes do cadastro de usuários

Resource        ../resources/base.resource

# Suite Setup        Log    Tudo aqui acontece antes da Suite(antes de todos os testes)
# Suite Teardown     Log    Tudo aqui acontece depois da Suite(depois de todos os testes)

Test Setup        Start Session
Test Teardown     Take Screenshot

*** Test Cases ***
Deve poder cadastrar um novo usuário

        ${user}            Create Dictionary
        ...    name=Cassito
        ...    email=ctmj@gmail.com
        ...    password=pwd123



# antes de implemntar o método def insert_user(name, email, password):era assim como esta aqui embaixo q funcionava      
#        ${name}            Set Variable    Cassito
#         ${email}           Set Variable    ctmj@gmail.com
#         ${password}        Set Variable    pwd123

        Remove user from database    ${user}[email]
        Go to signup page
        Submit signup form    ${user}
        Notice should be      Boas vindas ao Mark85, o seu gerenciador de tarefas.

# antes de ter passado o parametro acima Test Setup Start Session era assim q estava
        # Start Session

       
#        antes de ter passado o parametro acima Test Teardown Take Screenshot era assim q estava
#         Take Screenshot

#  Pra busucar pelo id é id=name, pra buscar pelo id é pra fazer uma busca na pagina ctrl + f e digitar no campo //input[@id="name"]
#  pra clicar no button da pra fazer a pesquisa por css button[type=submit] se fosse utilizar o xpath pra localizar seria: //button[text()="Cadastrar"]
# pra instalar a biblioteca de massa fake é pip install robotframework-faker
# pra buscar por classe basta digitar: .notice
# se # buscar por ID o . busca por classe pra usar aqui foi feito assim: .notice p(pe é o filho da classe notice)
# caso eu queira chmar por css posso fazer assim: css=#email
# a variavel da url esta em caixa alta pq é uma variavel q vai ser utilizada em outro escopo em outro arquivo 
# por ID pode fazer assim: id=buttonSignup ou seja sempre id=mais o valor q foi pego

Não deve permitir o cadastro com email duplicado
    [Tags]    dup

    ${user}        Create Dictionary
    ...    name=Fassito
    ...    email=fassito@gmail.com
    ...    password=pwd123
# antes de implemntar o método def insert_user(name, email, password):era assim como esta aqui embaixo q funcionava 
#     ${name}            Set Variable    Fassito
#     ${email}           Set Variable    fassito@gmail.com
#     ${password}        Set Variable    pwd123

    Remove user from database        ${user}[email]
    Insert user from database        ${user}

    #antes de alterar a função insert  from para user, era assim q estava:
#     Insert user from database        ${user}[name]    ${user}[email]    ${user}[password]
# antes de ter passado o parametro acima Test Setup Start Session era assim q estava
        # Start Session
        Go to signup page
        Submit signup form    ${user}
        Notice should be      Oops! Já existe uma conta com o e-mail informado.
#      antes de ter passado o parametro acima Test Teardown Take Screenshot era assim q estava
#      Take Screenshot

Campos obrigatorios
    [Tags]    required    
    ${user}            Create Dictionary
        ...            name=${EMPTY}
        ...            email=${EMPTY}
        ...            password=${EMPTY}

    Go to signup page
    Submit signup form        ${user}

    Alert should be        Informe seu nome completo
    Alert should be        Informe seu e-email
    Alert should be        Informe uma senha com pelo menos 6 digitos

Não deve cadastrar com email inválido
    [Tags]    inv_email

    ${user}            Create Dictionary

    ...                name=Rafa
    ...                email=xavier.com
    ...                password=123456
        
    Go to signup page
    Submit signup form        ${user}
    Alert should be           Digite um e-mail válido

Não deve cadastrar com senha muito curta
    [Tags]    Temp
    @{password_List}        Create List     1    12    123    1234    12345

    FOR    ${password}    IN    @{password_List}
       ${user}            Create Dictionary
        ...            name=cassito
        ...            email=cassito@gmail
        ...            password=${password}

    Go to signup page
    Submit signup form        ${user}

    Alert should be        Informe uma senha com pelo menos 6 digitos
        
    END    


# Não deve cadastrar senha com 1 digito
#     [Tags]    short_pass 
#     [Template]
#     Short password   1
   
# Não deve cadastrar senha com 2 digitos
#     [Tags]    short_pass 
#     [Template]
#     Short password   12

# Não deve cadastrar senha com 3 digitos
#     [Tags]    short_pass 
#     [Template]
#     Short password   123

# Não deve cadastrar senha com 4 digitos
#     [Tags]    short_pass 
#     [Template]
#     Short password   1234

# Não deve cadastrar senha com 5 digitos
#     [Tags]    short_pass 
#     [Template]
#     Short password   12345
               