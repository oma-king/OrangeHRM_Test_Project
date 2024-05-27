*** Settings ***
Library     SeleniumLibrary
Resource    ../Resources/Modules/login-module.robot
Resource    ../Resources/Settings/global-variable.robot
Resource    ../Resources/Modules/admin-module.robot
Resource    ../Resources/Modules/logout-module.robot
Resource    ../Resources/Modules/pim-module.robot
Resource    ../Resources/Modules/leave-module.robot

*** Variables ***
${FIRST_NAME}              Oussama
${LAST_NAME}               MAHMOUD
${EMPLOYEE_ID}             9999
${EMPLOYEE_NAME_PIM}       ${FIRST_NAME} ${LAST_NAME}
${LEAVE_TYPE}              CAN - FMLA
${FROM_DATE}               2024-06-01
${TO_DATE}                 2024-06-10
${COMMENT}                 Family Vacation
${LEAVE_STATUS_PENDING}    Pending Approval
*** Keywords ***

Initialization Browser
    Open Browser               url=${URL}    browser=${CHROME}
    Maximize Browser Window

User Login
    Input Credentials     USERNAME=Admin    PASSWORD=admin123
    Click Login Button

*** Test Cases ***

Login with correct Username and Password then Logout
    Initialization Browser
    User Login
    Verify Connection
    Sleep                     5s
    Logout
    Close Browser

Admin Add User
    Initialization Browser
    User Login
    Verify Connection
    Open Admin Module
    Open Add User Form
    Add User                  EMPLOYEE_NAME=Amelia    USER_USERNAME=omahmoud    USER_PASSWORD=Om@h0ud2024
    Sleep                     5s
    Logout
    Close Browser

PIM Add then Update Employee
    Initialization Browser
    User Login
    Verify Connection
    Open PIM Module
    Open Add Employee Form
    Add Employee               ${FIRST_NAME}           ${LAST_NAME}     ${EMPLOYEE_ID}
    Verify Employee In List    ${EMPLOYEE_NAME_PIM}    ${FIRST_NAME}    ${LAST_NAME}
    Sleep                      5s                      
    Modify Employee            ${EMPLOYEE_NAME_PIM}    ${FIRST_NAME}    ${LAST_NAME}
    Logout
    Close Browser

Apply and Verify Leave
    Initialization Browser
    User Login
    Verify Connection
    Open Leave Module
    Sleep                     10
    Open Apply Leave Form
    Apply Leave               ${LEAVE_TYPE}              ${FROM_DATE}    ${TO_DATE}    ${COMMENT}
    Verify Leave Request      ${LEAVE_STATUS_PENDING}
    Close Browser