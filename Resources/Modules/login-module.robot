*** Settings ***
Library    SeleniumLibrary


*** Variables ***

${USERNAME_FIELD}    name:username
${PASSWORD_FIELD}    name:password
${LOGIN_BUTTON}      css:.oxd-button

*** Keywords ***
Input Credentials
    [Arguments]    ${USERNAME}     ${PASSWORD}
    Wait Until Element Is Visible    ${USERNAME_FIELD}
    Input Text    ${USERNAME_FIELD}    ${USERNAME}
    Input Text    ${PASSWORD_FIELD}    ${PASSWORD}
    
   
Click Login Button
    Click Button     ${LOGIN_BUTTON}

Verify Connection
    Wait Until Element Is Visible    ${DASHBOARD}
    Page Should Contain    Dashboard