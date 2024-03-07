*** Settings ***
Resource    ../../resources/page_objects/careers.robot
Resource    ../../resources/page_objects/search_results.robot
Resource    ../../resources/keywords/open_browser.robot
Resource    ../../resources/keywords/custom_keywords.robot
Library    SeleniumLibrary
Library    Collections
Library    String

*** Variables ***
${JOBTITLE}     Test
${COUNTRY1}      Netherlands
${netherlands_subfilter_xpath}    xpath=//span[@class="result-text" and contains(text(), "${COUNTRY1}")]

*** Test Cases ***
Test Case 1 - Search Jobs by Title "Test" - Verify Multi-Location and Refine to Netherlands
    [Documentation]     This test case verifies search results include positions from multiple locations and refines search to "Netherlands" and ensures results are only from that country.
    [Tags]    job_title_search
    [Teardown]    Close Browser

    Open Just Eat Takeaway Careers Page
    Verify Global Search Initial State
    Input Job Title       ${JOBTITLE}
    Verify Location Field Is Empty
    Confirm Search
    ${foundJobs}=   Execute Comprehensive Job Search
    Verify Jobs Are From Multiple Locations     ${foundJobs}
    Refine Search By Country    ${COUNTRY1}
    ${foundJobs2}=   Execute Comprehensive Job Search
    Verify Jobs Location Is Netherlands Only    ${foundJobs2}

*** Keywords ***
Input Job Title
    [Arguments]     ${VALUE}
    Input Text      ${searchJobTitleBox}      ${VALUE}

Verify Location Field Is Empty
    ${locationTextBoxValue}=    Get Value    ${searchLocationBox}
    Should Be Equal     ${locationTextBoxValue}     ${EMPTY}

Verify Jobs Are From Multiple Locations
    [Arguments]    ${jobsList}
    ${uniqueLocations}=    Create List
    FOR    ${job}    IN    @{jobsList}
        ${location}=    Get From Dictionary    ${job}    location
        Run Keyword If    '${location}' not in ${uniqueLocations}    Append To List    ${uniqueLocations}    ${location}
    END
    Log     ${uniqueLocations}
    ${numberOfUniqueLocations}=    Get Length    ${uniqueLocations}
    Should Be True    ${numberOfUniqueLocations} > 1

Refine Search By Country
    [Arguments]     ${COUNTRY1}
    Wait Until Element Is Visible       ${countryAccordion}
    Click Element    ${countryAccordion}
    Wait Until Element Is Visible       ${netherlands_subfilter_xpath}
    Click Element    ${netherlands_subfilter_xpath}
    Wait Until Element Is Visible        xpath=//li[contains(@class, 'tag')]//span[text()='Netherlands']
    Delete All Cookies
    Sleep       2s

Verify Jobs Location Is Netherlands Only
    [Documentation]    Verifies that each job in the provided list is located in the Netherlands.
    [Arguments]    ${jobsList}
    ${countries}=    Create List
    FOR    ${job}    IN    @{jobsList}
        ${location}=    Get From Dictionary    ${job}    location
        ${locationParts}=    Split String    ${location}    ,
        ${country}=    Get From List    ${locationParts}    -1
        ${trimmedCountry}=    Strip String    ${country}    # Trim leading and trailing whitespace
        Should Be Equal    ${trimmedCountry}    Netherlands
    END
