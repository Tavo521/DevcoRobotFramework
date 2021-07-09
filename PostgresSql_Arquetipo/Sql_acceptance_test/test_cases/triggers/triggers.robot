*** Settings ***
Library         OperatingSystem
Library         DatabaseLibrary
Resource        ../../resources/setup_test.resource

Suite Setup         SeTupTest
Suite Teardown      Disconnect From Database

*** Variables ***
${result}        3

*** Test Cases ***
the trigger should save the update in the update_products table
    
    ${output}   Execute Sql String   DELETE FROM Price_Audits WHERE book_id = 3
    should be equal as strings  ${output}   None
    ${output}   Execute Sql String  DELETE FROM price WHERE id = 3
    should be equal as strings  ${output}   None
    ${output}   Execute Sql String  INSERT INTO Price VALUES (3, 400);
    should be equal as strings  ${output}   None
    ${query}    query   SELECT book_id FROM Price_Audits;
    should be equal as integers     ${query[0][0]}     ${result}
          

    