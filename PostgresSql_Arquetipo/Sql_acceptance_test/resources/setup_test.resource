

| *** Settings ***    |
| Resource            | ../resources/connection_database_local.resource
| Resource            | ../resources/connection_database_pipeline.resource
| Library             | ../resources/access_secrets.py


| *** Variables ***   | 
| ${enviroment}        

*** Keywords ***
SetupTest
    Run Keyword IF      '${enviroment}' == 'local'          Connect to database local
    ...  ELSE IF        '${enviroment}' == 'pipeline'         Connect to database origen
    ...  ELSE            Log    setupTest went wrong. Check wheter the variable
    ...                         'enviromentToRunTest' (${enviroment}) is correct. 
    