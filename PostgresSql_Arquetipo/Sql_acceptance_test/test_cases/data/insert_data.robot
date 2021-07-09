*** Settings ***
Library         OperatingSystem
Library         DatabaseLibrary
Resource        ../../resources/setup_test.resource

Suite Setup         SeTupTest
Suite Teardown      Disconnect From Database

*** Variables ***
${script_sql_tablas}            ./resources/test_data/tablas.sql
${script_sql_procedimientos}    ./resources/test_data/procedimientos.sql
${script_sql_insert}            ./resources/test_data/insert.sql
*** Test Cases ***
Inserting tablas data
    ${output}   Execute sql script  ${script_sql_tablas}
    log to console  ${output}
    should be equal as strings   ${output}    None
