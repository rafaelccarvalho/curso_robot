*** Settings ***
Documentation            Cenarios de cadastro de tarefas

Resource       ../../resources/base.resource
# Resource    ../../resources/pages/TasksPage.resource
# Resource    ../../resources/pages/TaskCreatePage.robot

Test Setup        Start Session
Test Teardown     Take Screenshot

*** Test Cases ***
Deve poder cadastrar uma nova tarefa

   ${data}    Get fixtures     tasks   create

    Clean user from database    ${data}[user][email]
    insert user from database    ${data}[user]

    Submit login form            ${data}[user]
    User should be logged in     ${data}[user][name]

    Go to task form
    Submit task form                ${data}[task]
    Task should be registered       ${data}[task][name]

Não deve cadastrar tarefa com nome duplicado
    [Tags]    dup

    ${data}    Get fixtures    tasks    duplicate    
   # Dado que eu tenho um novo usuário 
    Clean user from database    ${data}[user][email]
    insert user from database    ${data}[user]
    # E que esse usuário ja cadastrou uma tarefa
    Post user session    ${data}[user]
    Post a new task      ${data}[task]
    # E que estou logado na aplicação web
    Submit login form            ${data}[user]
    User should be logged in     ${data}[user][name]
    #Quando tento cadastrar essa tarefa que ja foi cadastrada
    Go to task form
    Submit task form             ${data}[task]
    # Então devo ver uma notificação de dupliicidade
    Notice should be        Oops! Tarefa duplicada.

Não deve cadastrar uma nova tarefa quando atinge o limite de tags
    [Tags]    tags_limit   
    
    ${data}    Get fixtures    tasks    tags_limit

    Clean user from database    ${data}[user][email]
    insert user from database    ${data}[user]

    Submit login form            ${data}[user]
    User should be logged in     ${data}[user][name]

    Go to task form
    Submit task form             ${data}[task]

    Notice should be        Oops! Limite de tags atingido.



