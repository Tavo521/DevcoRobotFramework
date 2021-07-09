*** Settings ***
Library     DatabaseLibrary
Library     OperatingSystem
Library     ../resources/configure.py

*** Variables ***
${DBName}       devcopruebas
${DBHost}       ec2-34-201-132-144.compute-1.amazonaws.com
${DBPort}       5432

*** Keywords ***
Connect to database local
    ${lib}=         Get Library Instance    configure
    ${config}=  Call Method   ${lib}     get_variables   local
    ${DBUser}=        Set Variable   ${config['dbconfig'].user}
    ${DBPass}=        Set Variable   ${config['dbconfig'].pwd}   
    ${output}       ${output}   Connect To Database     psycopg2     ${DBName}       ${DBUser}       ${DBPass}       ${DBHost}       ${DBPort}
    log to console  ${output}
    should be equal as strings   ${output}    None
    [Return]    ${output}