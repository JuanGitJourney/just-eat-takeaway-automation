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
${CATEGORY}     Sales
${COUNTRY2}     Germany

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
    ${foundJobs}=   Execute Comprehensive Job Search
    Verify Jobs Location Is Netherlands Only    ${foundJobs}

Test Case 2 - Search Jobs by Category "Sales" - Verify Selection and Refine to Germany with Matching Results
    [Documentation]     This test case verifies "Sales" is selected and the initial search result count is accurate, refines search to "Germany" and ensures category remains "Sales" and results match the criteria.
    [Tags]      job_categories_search
    [Teardown]    Close Browser

    Open Just Eat Takeaway Careers Page
    Verify Global Search Initial State
    Verify Job Categories Dropdown
    Verify Job Category Is Listed       ${CATEGORY}
    Click Element       css=a.au-target[data-ph-at-data-text='Sales']
    Scroll Element Into View   css=ppc-content[data-ph-at-id='heading-text']
    Verify Target Category Is Selected
    ${foundJobs}=   Execute Comprehensive Job Search
    Refine Search By Country    ${COUNTRY2}
    ${foundJobs}=   Execute Comprehensive Job Search
    Verify Jobs Category Is Sales Only    ${foundJobs}


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

Verify Jobs Category Is Sales Only
    [Documentation]    Verifies that each job in the provided list belongs to the sales category.
    [Arguments]    ${jobsList}
    ${countries}=    Create List
    FOR    ${job}    IN    @{jobsList}
        ${category}=    Get From Dictionary    ${job}    category
        Should Be Equal    ${category}    Sales
    END














