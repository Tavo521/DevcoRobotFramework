*** Settings ***
Library         OperatingSystem
Library         DatabaseLibrary
Resource        ../../resources/setup_test.resource

Suite Setup         SeTupTest
Suite Teardown      Disconnect From Database

*** Test Cases ***
function values accounts in Funct_test should return 2
    ${result}      query       Select Func_Test()
    should be equal as integers     ${result[0][0]}      2