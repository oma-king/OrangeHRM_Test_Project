*** Settings ***
Library    SeleniumLibrary
Library    Collections

*** Variables ***
${PIM_MODULE}                    xpath://span[normalize-space()='PIM']
${ADD_EMPLOYEE_BUTTON}           xpath://a[normalize-space()='Add Employee']
${FIRST_NAME_FIELD}              xpath://input[@name='firstName']
${LAST_NAME_FIELD}               xpath://input[@name='lastName']
${EMPLOYEE_ID_FIELD}             xpath:(//input[@class='oxd-input oxd-input--active'])[2]
${SAVE_BUTTON}                   xpath:(//button[normalize-space()='Save'])[1]
${SAVE_BUTTON_UPDATE}            xpath://button[@type='submit' and contains(@class, 'oxd-button--secondary')]
${EMPLOYEE_LIST}                 xpath://a[normalize-space()='Employee List']
${SEARCH_EMPLOYEE_NAME_FIELD}    xpath:/html[1]/body[1]/div[1]/div[1]/div[2]/div[2]/div[1]/div[1]/div[2]/form[1]/div[1]/div[1]/div[1]/div[1]/div[2]/div[1]/div[1]/input[1]
${SEARCH_BUTTON}                 xpath://button[normalize-space()='Search']
${EMPLOYEE_TABLE}                xpath://div[@class='orangehrm-container']
${EMPLOYEE_TABLE_RESULT}         xpath:(//div[@class='orangehrm-horizontal-padding orangehrm-vertical-padding'])[1]
${PENCIL_UPDATE}                 xpath:(//div[@class='oxd-table-row oxd-table-row--with-border oxd-table-row--clickable'])[1]
${LOADER}                        xpath://div[@class='oxd-form-loader']
${JOB_FORM}                      xpath:(//a[normalize-space()='Job'])[1]
${JOB_SELECTOR}                  xpath:(//div[@class='oxd-select-text-input'][normalize-space()='-- Select --'])[1]
${JOB_OPTION}                    xpath:(//div[@role='listbox']//child::div)[3]

*** Keywords ***

Open PIM Module
    Wait Until Element Is Visible    ${PIM_MODULE}
    Click Element                    ${PIM_MODULE}

Open Add Employee Form
    Wait Until Element Is Visible    ${ADD_EMPLOYEE_BUTTON}
    Click Element                    ${ADD_EMPLOYEE_BUTTON}

Add Employee
    [Arguments]                      ${FIRST_NAME}           ${LAST_NAME}      ${EMPLOYEE_ID}
    Wait Until Element Is Visible    ${FIRST_NAME_FIELD}
    Input Text                       ${FIRST_NAME_FIELD}     ${FIRST_NAME}
    Input Text                       ${LAST_NAME_FIELD}      ${LAST_NAME}
    Input Text                       ${EMPLOYEE_ID_FIELD}    ${EMPLOYEE_ID}
    Sleep                            4
    Click Button                     ${SAVE_BUTTON}
    Sleep                            10
    Wait Until Element Is Visible    ${EMPLOYEE_LIST}

Verify Employee In List
    [Arguments]                      ${EMPLOYEE_NAME_PIM}             ${FIRST_NAME}           ${LAST_NAME}
    Click Element                    ${EMPLOYEE_LIST}
    Wait Until Element Is Visible    ${SEARCH_EMPLOYEE_NAME_FIELD}
    Input Text                       ${SEARCH_EMPLOYEE_NAME_FIELD}    ${EMPLOYEE_NAME_PIM}
    Click Button                     ${SEARCH_BUTTON}
    Wait Until Element Is Visible    ${EMPLOYEE_TABLE}
    Wait Until Element Contains      ${EMPLOYEE_TABLE}                ${FIRST_NAME}
    Wait Until Element Contains      ${EMPLOYEE_TABLE}                ${LAST_NAME}

Wait Until Loader Disappears
    Wait Until Element Is Not Visible    ${LOADER}    timeout=20s

Modify Employee
    [Arguments]                      ${EMPLOYEE_NAME_PIM}          ${FIRST_NAME}                 ${LAST_NAME}
    Wait Until Element Is Visible    ${PENCIL_UPDATE}              
    Click Element                    ${PENCIL_UPDATE}
    Wait Until Element Is Visible    ${JOB_FORM} 
    Click Element                    ${JOB_FORM}                   
    Wait Until Element Is Visible    ${JOB_SELECTOR} 
    Click Element                    ${JOB_SELECTOR}                   
    Sleep                            4  
    Click Element                    ${JOB_OPTION}
    Wait Until Element Is Visible    css:.oxd-select-text-input
    ${GETJOB}=                       Get Text                      css:.oxd-select-text-input
    Sleep                            10
    Wait Until Element Is Visible    ${SAVE_BUTTON_UPDATE}
    Sleep                            10
    Click Element                    ${SAVE_BUTTON_UPDATE}
    Wait Until Element Is Visible    ${EMPLOYEE_LIST}
    Verify Employee In List          ${EMPLOYEE_NAME_PIM}          ${GETJOB}                     ${LAST_NAME}
