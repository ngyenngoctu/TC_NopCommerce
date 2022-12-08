*** Settings ***
Library             RPA.Tables
Library             RPA.Excel.Files
Library             Collections
Library             RPA.HTTP
Library             String
Resource            ../Resource/keywordExcel.robot

Test Setup          Run Keywords    Open my Browser
Task Teardown       Run Keywords    Finish TestCase


*** Variables ***
${EXCEL_FILE}       /path/to/excel.xlsx
@{heading}
...                 ID
...                 FirstName
...                 LastName
...                 Gmail
...                 Company
...                 Password
...                 ConfirmPassword
...                 Dayofbirth
...                 Monthofbirth
...                 Yearofbirth
@{rows}             ${heading}
${dayofbirth}       20
${monthofbirth}     June
${yearofbirth}      2000


*** Tasks ***
Testing with excel file
    [Documentation]    Create new file xlsx, save data in the file.
    ...    Register using file xlsx.
    ...    Login and add random products with each account, using file xlsx.
    Creating new excel file.
    Register an account using data from an excel file
    Login your account with data from excel file and add random product


*** Keywords ***
Creating new excel file.
    Create Workbook    my_account.xlsx
    FOR    ${index}    IN RANGE    1    11
        ${newfirstName}=    genarate random firstName
        ${newlastName}=    genarate random lastName
        ${newgmail}=    genarate random gmail
        ${newcompany}=    genarate random company
        ${newpassword}=    genarate random password
        @{row}=    Create List
        ...    ${index}
        ...    ${newfirstName}
        ...    ${newlastName}
        ...    ${newgmail}
        ...    ${newcompany}
        ...    ${newpassword}
        ...    ${newpassword}
        ...    ${dayofbirth}
        ...    ${monthofbirth}
        ...    ${yearofbirth}
        Append To List    ${rows}    ${row}
    END
    Append Rows to Worksheet    ${rows}
    Save Workbook

Register an account using data from an excel file
    Open Workbook    my_account.xlsx
    ${enterContentss}=    Read Worksheet As Table    header=True
    Close Workbook
    FOR    ${enterContentRegister}    IN    @{enterContentss}
        Register account    ${enterContentRegister}
    END

Register account
    [Arguments]    ${enterContentRegister}
    CLick on "Register on Menu" at form
    Fill in register information    ${enterContentRegister}
    CLick on "button REGISTER" at form
    CLick on "Log out on Menu" at form

Fill in register information
    [Arguments]    ${enterContentRegister}
    Enter "FirstName" with "${enterContentRegister}[FirstName]" at form
    Enter "LastName" with "${enterContentRegister}[LastName]" at form
    Enter "Dayofbirth" with "${enterContentRegister}[Dayofbirth]" at form
    Enter "Monthofbirth" with "${enterContentRegister}[Monthofbirth]" at form
    Enter "Yearofbirth" with "${enterContentRegister}[Yearofbirth]" at form
    Enter "gmail register" with "${enterContentRegister}[Gmail]" at form
    Enter "Company" with "${enterContentRegister}[Company]" at form
    Enter "password_register" with "${enterContentRegister}[Password]" at form
    Enter "comfirmpassword_register" with "${enterContentRegister}[ConfirmPassword]" at form

Login your account with data from excel file and add random product
    Open Workbook    my_account.xlsx
    ${enterContentss}=    Read Worksheet As Table    header=True
    Close Workbook
    FOR    ${enterContentLogin}    IN    @{enterContentss}
        Login account and add random 1 product    ${enterContentLogin}
    END

Login account and add random 1 product
    [Arguments]    ${enterContentLogin}
    CLick on "Log in on Menu" at form
    Fill in login information    ${enterContentLogin}
    CLick on "button LOGIN" at form
    Add to cart any 1 product    ${enterContentLogin}[Gmail]
    CLick on "Log out on Menu" at form

Fill in login information
    [Arguments]    ${enterContentLogin}
    Enter "gmail" with "${enterContentLogin}[Gmail]" at form
    Enter "password" with "${enterContentLogin}[Password]" at form

Add to cart any 1 product
    [Arguments]    ${enterContentLogin}
    CLick on "computers category" at form
    ${COUNT_TypeCategory}=    Get Element Count    xpath=//div[@class="item-box"]
    ${numberCategory}=    Evaluate    random.sample(range(1, ${COUNT_TypeCategory}),1)
    Click Element    xpath=//div[@class="item-grid"]/div${numberCategory}//a
    ${COUNT_Product}=    Get Element Count    xpath=//div[@class="item-box"]
    ${numberProduct}=    Evaluate    random.sample(range(1, ${COUNT_Product}),1)
    IF    ${numberCategory} == [1] and ${numberProduct} == [1]
        Choose the Product 1_1
    ELSE IF    ${numberCategory} == [2] and ${numberProduct} == [1]
        Choose the Product 2_1
    ELSE IF    ${numberCategory} == [3] and ${numberProduct} == [1]
        Choose the Product 3_1
    ELSE
        Click Button    xpath=//div[@class="item-grid"]/div${numberProduct}//button
        CLick on "shopping cart on dialog" at form
    END
    Collect the results    ${enterContentLogin}

Collect the results
    [Arguments]    ${enterContentLogin}
    Capture Page Screenshot    ${CURDIR}\\img\\imgAddToCart\\${enterContentLogin}

Choose the Product 1_1
    Click Element    xpath=//h2[@class='product-title']//a[normalize-space()='Build your own computer']
    Click Element    xpath=//dd[@id="product_attribute_input_2"]//option[3]
    Click Element    xpath=//input[@id='product_attribute_3_7']
    Click Button    xpath=//button[@id="add-to-cart-button-1"]
    CLick on "shopping cart on dialog" at form

Choose the Product 2_1
    Click Element    xpath=//h2[@class='product-title']//a[contains(text(),'Apple MacBook Pro 13-inch')]
    Click Button    xpath=//button[@id='add-to-cart-button-4']
    CLick on "shopping cart on dialog" at form

Choose the Product 3_1
    Click Button    xpath=//button[@class="button-2 add-to-compare-list-button"][1]
    CLick on "comparison on dialog" at form
