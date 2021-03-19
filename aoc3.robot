*** Settings ***
Library    OperatingSystem
Library    Collections
Library    String
Library    Reserved
*** Variables ***


*** Tasks ***
TestInput
    ${slope}    Get slope from file   testSlope
    Ride the slope    ${slope} 

MyInput   
    ${slope}    Get slope from file   inputSlope
    Ride the slope    ${slope}

*** Keywords ***
Ride the slope
    [Arguments]    ${slope}
    ${treesEncountered}     Set Variable    ${0}
    ${position}     Set Variable    ${0}
    ${mapWidth}    Get Length    ${slope}[0]
    FOR    ${line}  IN   @{slope}
        IF    ${position} > ${mapWidth-1}
            ${position}    Set Variable    ${position-${mapWidth}}
        END
        ${postitionOnSlope}    Get Substring    ${line}    ${position}    ${position+1}
        IF     $postitionOnSlope == '\#'
            ${treesEncountered}    Set Variable    ${treesEncountered+1}
        END
    ${position}    Set Variable    ${position+3}
    END
    Log To Console    ${treesEncountered}

Get slope from file
    [Arguments]    ${fileName}
    ${slope}    Get File    ${fileName}
    @{slope}    Split To Lines    ${slope}
    [Return]   @{slope}