*** Settings ***
Library    SeleniumLibrary


*** Variables ***
${DROPDOWN_FIRST_STATE}    css:.oxd-userdropdown-tab
${LOGOUT_LIST}             xpath://a[normalize-space()='Logout']

*** Keywords ***

Logout
    Wait Until Element Is Visible    ${DROPDOWN_FIRST_STATE}
    Click Element    locator=${DROPDOWN_FIRST_STATE}
    Wait Until Element Is Visible    ${LOGOUT_LIST}
    Click Element    locator=${LOGOUT_LIST}
    Wait Until Element Is Visible    ${LOGIN_BUTTON}