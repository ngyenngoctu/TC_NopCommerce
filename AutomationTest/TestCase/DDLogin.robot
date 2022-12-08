*** Settings ***
Library             SeleniumLibrary
Resource            ../Resource/keywordExcel.robot
Library             DataDriver    ./Data/testDataLogin2xlsx

Suite Setup         Run Keywords    Open my Browser    Create register account
Test Setup          Open my Browser
Test Teardown       Finish TestCase


*** Test Cases ***
LoginTestwithExcel    [Documentation]    Testing all cases login fail
    ...    Not filling, incorrect email, incorrect password, incorrect email and password, error gmail.
    [Tags]    two required fields
    [Template]    Invalid Login Scenarious
    ${enterGmail}    ${enterPassword}    ${erro_msg}


*** Keywords ***
Invalid Login Scenarious
    [Arguments]    ${enterGmail}    ${enterPassword}    ${erro_msg}
    Set Selenium Implicit Wait    1s
    CLick on "Log in on Menu" at form
    Enter "gmail" with "${enterGmail}" at form
    Enter "password" with "${enterPassword}" at form
    CLick on "button LOGIN" at form
    Sleep    1s
    IF    "${erro_msg}" == "Please enter your email"
        Verify "Please enter your email" with "Please enter your email" at form
    ELSE IF    "${erro_msg}" == "Wrong email"
        Verify "Wrong email" with "Wrong email" at form
    ELSE IF    "${erro_msg}" == "login successfully"
        Verify "login successfully" with "Log out" at form
    ELSE
        Verify "erro massage" with "${erro_msg}" at form
    END
    Collect the results - "${erro_msg}" save folder imgLogin.

Forgot password Scenarious
    [Arguments]    ${enterGmail}    ${FGP_notification}
    Set Selenium Implicit Wait    1s
    CLick on "Log in on Menu" at form
    CLick on "forgot password" at form
    Enter "gmail" with "${enterGmail}" at form
    CLick on "button RECOVER" at form
    IF    "${FGP_notification}" == "Enter your email"
        Verify "Enter your email" with "Enter your email" at form
    ELSE IF    "${FGP_notification}" == "Wrong email"
        Verify "Wrong email" with "Wrong email" at form
    ELSE IF    "${FGP_notification}" == "Email with instructions has been sent to you."
        Verify "recover successfully" with "${FGP_notification}" at form
    ELSE
        Verify "erro email recover" with "${FGP_notification}" at form
    END
    Sleep    1.5s
    Collect the results - "${FGP_notification}" save folder imgLogin.

Go to login page
    CLick on "Log in on Menu" at form

Open new tab and go to loginPage
    Execute Javascript    window.open('https://demo.nopcommerce.com/')
    Switch Window    locator=NEW

Collect the results - "${sc}" save folder imgLogin.
    Capture Page Screenshot    ${CURDIR}\\img\\imgLogin\\${sc}.png
