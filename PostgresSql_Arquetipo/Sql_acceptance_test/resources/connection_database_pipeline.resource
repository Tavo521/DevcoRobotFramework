*** Settings ***
Library     DatabaseLibrary
Library     OperatingSystem
Library		access_secrets.py

*** Variables ***
${DBName}       dvdrental
${DBHost}       IP
${DBPort}       5432
*** Keywords ***
Connect to database origen
    ${config}=     Get Secret     sasamqdb  
    ${DBUser}=        Set Variable   ${config['dbconfig'].user}
    ${DBPass}=        Set Variable   ${config['dbconfig'].pwd} 
    ${output}       ${output}   Connect To Database     psycopg2     ${DBName}       ${DBUser}       ${DBPass}       ${DBHost}       ${DBPort}
    log to console  ${output}
    should be equal as strings   ${output}    None
    [Return]    ${output}
