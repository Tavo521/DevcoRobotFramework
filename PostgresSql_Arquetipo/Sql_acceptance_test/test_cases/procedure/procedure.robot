*** Settings ***
Library         OperatingSystem
Library         DatabaseLibrary
Resource        ../../resources/setup_test.resource

Suite Setup         SeTupTest
Suite Teardown      Disconnect From Database

*** Test Cases ***

Verify Execute SQL String 
    @{ParamList} =     Create List    1   2   1000
    @{QueryResults} =  Call Stored Procedure    transfer   ${ParamList}
    Log    ${@{QueryResults} }
    Should Be Equal As Strings    ${output}    None