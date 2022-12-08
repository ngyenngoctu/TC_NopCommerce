*** Settings ***
Library     SeleniumLibrary
Library     String
Library     SeleniumLibrary


*** Variables ***
${Website_url}                      https://demo.nopcommerce.com/
${browser}                          chrome
${btnLogin}                         xpath=//button[normalize-space()='Log in']
${btnRegister}                      xpath=//button[@id='register-button']
${btn_Login_Menu}                   xpath=//a[normalize-space()='Log in']
${btn_Register_Menu}                xpath=//a[normalize-space()='Register']
${btn_LogOut_Menu}                  xpath=//a[normalize-space()='Log out']
${btn_RECOVER}                      xpath=//button[normalize-space()='Recover']
${e_ComputersCategory}              xpath=//ul[@class='top-menu notmobile']//a[normalize-space()='Computers']
${e_GotoSC_OnDialog}                xpath=//a[normalize-space()='shopping cart']
${e_GotoComparison_OnDialog}        xpath=//a[normalize-space()='product comparison']
${e_chk_RememberMe}                 xpath=//input[@id='RememberMe']
${e_forgot_password}                xpath=//a[normalize-space()='Forgot password?']
#field login
${txtGmail}                         xpath=//input[@id='Email']
${txtPassword}                      xpath=//input[@id='Password']
# field register
${txtFirstName_Register}            xpath=//input[@id='FirstName']
${txtLastName_Register}             xpath=//input[@id='LastName']
${txtEmail_Register}                xpath=//input[@id='Email']
${txtCompany_Register}              xpath=//input[@id='Company']
${txtPassword_Register}             xpath=//input[@id='Password']
${txtConfirmPassword_Register}      xpath=//input[@id='ConfirmPassword']
${Verify_RecoverSuccessfully}       xpath=(//div[@class='bar-notification success'])[1]/p
${Verify_loginSuccessfully}         xpath=//a[normalize-space()='Log out']
${Verify_RecoverNotFound}           xpath=(//div[@class='bar-notification error'])[1]/p
${erro_msg_login}                   xpath=//div[@class="message-error validation-summary-errors"]/ul
${erro_msg_EmailUnValid}            xpath=(//span[@class='field-validation-error'])[1]
${erro_msg_WrongEmail}              xpath=//span[@id='Email-error']
${erro_FGP_EnterGmail}              xpath=(//span[@class='field-validation-error'])[1]/span


*** Keywords ***
Open my Browser
    Open Browser    ${Website_url}    ${browser}
    Maximize Browser Window
    Set Selenium Implicit Wait    1.5s

Finish TestCase
    Close Browser

Create register account
    CLick on "Register on Menu" at form
    Enter "first name" with "Tu" at form
    Enter "last name" with "Nguyen" at form
    Enter "gmail register" with "a7ngoctu@gmail.com" at form
    Enter "password register" with "123456" at form
    Enter "comfirmpassword register" with "123456" at form
    CLick on "button REGISTER" at form
    Close Browser

Enter "${type}" with "${entercontent}" at form
    IF    "${type}" == "gmail"
        Input Text    ${txtGmail}    ${entercontent}
    ELSE IF    "${type}" == "password"
        Input Text    ${txtPassword}    ${entercontent}
    ELSE IF    "${type}" == "first name"
        Input Text    ${txtFirstName_Register}    ${entercontent}
    ELSE IF    "${type}" == "last name"
        Input Text    ${txtLastName_Register}    ${entercontent}
    ELSE IF    "${type}" == "password_register"
        Input Text    ${txtPassword_Register}    ${entercontent}
    ELSE IF    "${type}" == "comfirmpassword_register"
        Input Text    ${txtConfirmPassword_Register}    ${entercontent}
    ELSE IF    "${type}" == "gmail register"
        Input Text    ${txtEmail_Register}    ${entercontent}
    ELSE IF    "${type}" == "FirstName"
        Input Text    ${txtFirstName_Register}    ${entercontent}
    ELSE IF    "${type}" == "LastName"
        Input Text    ${txtLastName_Register}    ${entercontent}
    ELSE IF    "${type}" == "Dayofbirth"
        Click Element    xpath=//option[normalize-space()='${entercontent}']
    ELSE IF    "${type}" == "Monthofbirth"
        Click Element    //option[normalize-space()='${entercontent}']
    ELSE IF    "${type}" == "Yearofbirth"
        Click Element    xpath=//option[normalize-space()='${entercontent}']
    ELSE IF    "${type}" == "Company"
        Input Text    ${txtCompany_Register}    ${entercontent}
        # ELSE IF    "${type}" == "Password"
        #    Input Text    ${txtPassword_Register}    ${entercontent}
        # ELSE IF    "${type}" == "ConfirmPassword"
        #    Input Text    ${txtConfirmPassword_Register}    ${entercontent}
    ELSE
        Log    null
    END

CLick on "${button}" at form
    IF    "${button}" == "button LOGIN"
        Click Button    ${btnLogin}
    ELSE IF    "${button}" == "button REGISTER"
        Click Button    ${btnRegister}
    ELSE IF    "${button}" == "Log in on Menu"
        Click Element    ${btn_Login_Menu}
    ELSE IF    "${button}" == "Register on Menu"
        Click Element    ${btn_Register_Menu}
    ELSE IF    "${button}" == "Log out on Menu"
        Click Element    ${btn_LogOut_Menu}
    ELSE IF    "${button}" == "checkbox Remember Me"
        Click Element    ${e_chk_RememberMe}
    ELSE IF    "${button}" == "forgot password"
        Click Element    ${e_forgot_password}
    ELSE IF    "${button}" == "button RECOVER"
        Click Button    ${btn_RECOVER}
    ELSE IF    "${button}" == "computers category"
        Click Element    ${e_ComputersCategory}
    ELSE IF    "${button}" == "shopping cart on dialog"
        Click Element    ${e_GotoSC_OnDialog}
    ELSE IF    "${button}" == "comparison on dialog"
        Click Element    ${e_GotoComparison_OnDialog}
    ELSE
        Log    null
    END

Verify "${type}" with "${entercontent}" at form
    IF    "${type}" == "erro massage"
        Element Should Contain    ${erro_msg_login}    ${entercontent}
    ELSE IF    "${type}" == "Please enter your email"
        Element Should Contain    ${erro_msg_WrongEmail}    ${entercontent}
    ELSE IF    "${type}" == "erro email recover"
        Element Should Contain    ${Verify_RecoverNotFound}    ${entercontent}
    ELSE IF    "${type}" == "Enter your email"
        Element Should Contain    ${erro_FGP_EnterGmail}    ${entercontent}
    ELSE IF    "${type}" == "Wrong email"
        Element Should Contain    ${erro_msg_EmailUnValid}    ${entercontent}
    ELSE IF    "${type}" == "login successfully"
        Element Should Contain    ${Verify_loginSuccessfully}    ${entercontent}
    ELSE IF    "${type}" == "recover successfully"
        Element Should Contain    ${Verify_RecoverSuccessfully}    ${entercontent}
    ELSE IF    "${type}" == "recover successfully"
        Element Should Contain    ${Verify_RecoverSuccessfully}    ${entercontent}
    ELSE
        Log    null
    END

genarate random gmail
    ${randomEmail}=    Generate Random String    7    [LETTERS][NUMBERS]
    ${khac}=    Set Variable    @gmail.com
    ${creatEmail}=    Catenate    ${randomEmail}${khac}
    RETURN    ${creatEmail}

genarate random firstName
    ${randomfirstName}=    Generate Random String    7    [LETTERS][NUMBERS]
    RETURN    ${randomfirstName}

genarate random lastName
    ${randomlastName}=    Generate Random String    7    [LETTERS][NUMBERS]
    RETURN    ${randomlastName}

genarate random company
    ${randomcompany}=    Generate Random String    7    [LETTERS][NUMBERS]
    RETURN    ${randomcompany}

genarate random password
    ${randomPassword}=    Generate Random String    7    [LETTERS][NUMBERS]
    RETURN    ${randomPassword}

Enter date of birth "${tday}${tmonth}${tyear}" in form
    Click Element    xpath=//option[normalize-space()='${tday}']
    Click Element    xpath=(//option[@value='${tmonth}'])[2]
    Click Element    xpath=//option[normalize-space()='${tyear}']
