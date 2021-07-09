*** Settings ***
Library         OperatingSystem
Library         DatabaseLibrary
Resource        ../../resources/setup_test.resource

Suite Setup         SeTupTest
Suite Teardown      Disconnect From Database


*** Test Cases ***


check accounts table exists in my database
    ${test}      query       SELECT EXISTS ( SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'accounts')
    should be equal as strings     ${test[0][0]}      True

check Price_Audits table exists in my database
    ${test}      query       SELECT EXISTS ( SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'price_audits')
    should be equal as strings     ${test[0][0]}      True

check price table exists in my database
    ${test}      query       SELECT EXISTS ( SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'price')
    should be equal as strings     ${test[0][0]}      True









