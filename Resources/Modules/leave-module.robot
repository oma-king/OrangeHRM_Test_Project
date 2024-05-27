*** Settings ***
Library    SeleniumLibrary
Library    Collections

*** Variables ***
${LEAVE_MODULE}            xpath://span[normalize-space()='Leave']
${APPLY_LEAVE_BUTTON}      xpath://a[normalize-space()='Apply']
${LEAVE_TYPE_DROPDOWN}     xpath:(//i[@class='oxd-icon bi-caret-down-fill oxd-select-text--arrow'])[1]
${LEAVE_TYPE_OPTION}       xpath://div[@role='listbox']//span[text()='${LEAVE_TYPE}']
${FROM_DATE_FIELD}         xpath:/html[1]/body[1]/div[1]/div[1]/div[2]/div[2]/div[1]/div[1]/form[1]/div[2]/div[1]/div[1]/div[1]/div[2]/div[1]/div[1]/input[1]
${TO_DATE_FIELD}           xpath:/html[1]/body[1]/div[1]/div[1]/div[2]/div[2]/div[1]/div[1]/form[1]/div[2]/div[1]/div[2]/div[1]/div[2]/div[1]/div[1]/input[1]
${COMMENT_FIELD}           xpath:(//textarea[@class='oxd-textarea oxd-textarea--active oxd-textarea--resize-vertical'])[1]
${SUBMIT_BUTTON}           xpath://button[normalize-space()='Apply']
${MY_LEAVE_LIST}           xpath://a[normalize-space()='My Leave']
${LEAVE_TABLE}             xpath://div[@role='table']
${LOADER}                  xpath://div[@class='oxd-form-loader']

*** Keywords ***

Open Leave Module
    Wait Until Element Is Visible    ${LEAVE_MODULE}
    Click Element                    ${LEAVE_MODULE}

Open Apply Leave Form
    Wait Until Element Is Visible    ${APPLY_LEAVE_BUTTON}
    Click Element                    ${APPLY_LEAVE_BUTTON}

Apply Leave
    [Arguments]                          ${LEAVE_TYPE}                                                 ${FROM_DATE}        ${TO_DATE}    ${COMMENT}
    Wait Until Element Is Visible        ${LEAVE_TYPE_DROPDOWN}
    Click Element                        ${LEAVE_TYPE_DROPDOWN}
    Click Element                        xpath://div[@role='listbox']//span[text()='${LEAVE_TYPE}']
    Input Text                           ${FROM_DATE_FIELD}                                            ${FROM_DATE}
    Press Keys                           ${TO_DATE_FIELD}                                              CTRL+a BACKSPACE
    Press Keys                           ${TO_DATE_FIELD}                                              BACKSPACE
    Input Text                           ${TO_DATE_FIELD}                                              ${TO_DATE}
    Input Text                           ${COMMENT_FIELD}                                              ${COMMENT}
    Sleep                                10
    Click Button                         ${SUBMIT_BUTTON}
    Wait Until Element Is Not Visible    ${LOADER}
    Wait Until Element Is Visible        ${MY_LEAVE_LIST}

Verify Leave Request
    [Arguments]                      ${LEAVE_STATUS_PENDING}
    Click Element                    ${MY_LEAVE_LIST}
    Wait Until Element Is Visible    ${LEAVE_TABLE}
    Sleep                            10
    Wait Until Element Contains      ${LEAVE_TABLE}      ${LEAVE_STATUS_PENDING}
