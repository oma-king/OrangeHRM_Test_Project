*** Settings ***
Library    SeleniumLibrary
Library    Collections

*** Variables ***
${ADMIN_FIRST_STATE}              xpath://span[normalize-space()='Admin']
${ADMIN_SECOND_STATE_USR_MGT}     xpath://span[normalize-space()='User Management']
${ADMIN_THIRD_STATE_USERS}        xpath://a[normalize-space()='Users']
${ADMIN_THIRD_STATE_USR_ADD}      xpath://button[normalize-space()='Add']
${ADMIN_FOURTH_STATE_USR_ADD}     xpath://h6[normalize-space()='Add User']
${USER_ROLE_DROPDOWN}             xpath:(//i[@class='oxd-icon bi-caret-down-fill oxd-select-text--arrow'])[1]
${USER_ROLE_OPTION}               xpath:(//div[@role='listbox']//child::div)[3]
${EMPLOYEE_NAME_FIELD}            xpath://input[@placeholder='Type for hints...']
${EMPLOYEE_NAME_FIELD_S}          xpath:(//div[@role='listbox'])[1]
${USER_STATUS_DROPDOWN}           xpath:(//i[@class='oxd-icon bi-caret-down-fill oxd-select-text--arrow'])[2]
${USER_STATUS_OPTION}             xpath:(//div[@role='listbox']//child::div)[2]
${USER_USERNAME_FIELD}            xpath:(//input[@class='oxd-input oxd-input--active'])[2]
${USER_PASSWORD_FIELD}            xpath:(//input[@type='password'])[1]
${USER_PASSWORD_CONFIRM_FIELD}    xpath:(//input[@type='password'])[2]
${USER_SAVE}                      xpath://button[normalize-space()='Save']
${ERROR_ELEMENT_CSS}              css:.oxd-input-field-error-message
${USERS_TABLE}                    (//div[@class='orangehrm-container'])[1]

*** Keywords ***

Open Admin Module
    Wait Until Element Is Visible    ${ADMIN_FIRST_STATE}
    Click Element                    locator=${ADMIN_FIRST_STATE}

Open Add User Form
    Wait Until Element Is Visible    ${ADMIN_SECOND_STATE_USR_MGT}
    Click Element                    locator=${ADMIN_SECOND_STATE_USR_MGT}
    Wait Until Element Is Visible    ${ADMIN_THIRD_STATE_USERS}
    Click Element                    locator=${ADMIN_THIRD_STATE_USERS}
    Wait Until Element Is Visible    ${ADMIN_THIRD_STATE_USR_ADD}
    Click Element                    locator=${ADMIN_THIRD_STATE_USR_ADD}

Add User
    [Arguments]                        ${EMPLOYEE_NAME}                  ${USER_USERNAME}    ${USER_PASSWORD}
    Wait Until Element Is Visible      ${ADMIN_FOURTH_STATE_USR_ADD}
    Click Element                      ${USER_ROLE_DROPDOWN}
    Click Element                      ${USER_ROLE_OPTION} 
    Click Element                      ${EMPLOYEE_NAME_FIELD}
    Input Text                         ${EMPLOYEE_NAME_FIELD}            ${EMPLOYEE_NAME}
    Wait Until Element Is Visible      ${EMPLOYEE_NAME_FIELD_S}
    Wait Until Element Contains        ${EMPLOYEE_NAME_FIELD_S}          ${EMPLOYEE_NAME}
    Press Keys                         ${EMPLOYEE_NAME_FIELD_S}          ENTER
    Click Element                      ${USER_STATUS_DROPDOWN}
    Click Element                      ${USER_STATUS_OPTION} 
    Input Text                         ${USER_USERNAME_FIELD}            ${USER_USERNAME}
    Input Text                         ${USER_PASSWORD_FIELD}            ${USER_PASSWORD}
    Input Text                         ${USER_PASSWORD_CONFIRM_FIELD}    ${USER_PASSWORD}
    Sleep                              7s
    Page Should Not Contain Element    ${ERROR_ELEMENT_CSS}
    Click Element                      ${USER_SAVE}
    Wait Until Element Is Visible      ${USERS_TABLE}
    Wait Until Element Contains        ${USERS_TABLE}                    ${USER_USERNAME}
