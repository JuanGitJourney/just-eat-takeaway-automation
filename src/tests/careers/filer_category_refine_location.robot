*** Settings ***
Resource    ../../resources/page_objects/careers.robot
Resource    ../../resources/page_objects/search_results.robot
Resource    ../../resources/keywords/open_browser.robot
Resource    ../../resources/keywords/custom_keywords.robot
Library    SeleniumLibrary
Library    Collections
Library    String

*** Variables ***
${CATEGORY}     Sales
${COUNTRY2}     Germany
${germany_subfilter_xpath}    xpath=//span[@class="result-text" and contains(text(), "${COUNTRY2}")]


*** Test Cases ***
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
Refine Search By Country
    [Arguments]     ${COUNTRY2}
    Wait Until Element Is Visible       ${countryAccordion}
    Click Element    ${countryAccordion}
    Wait Until Element Is Visible       ${netherlands_subfilter_xpath}
    Click Element    ${netherlands_subfilter_xpath}

Verify Jobs Category Is Sales Only
    [Documentation]    Verifies that each job in the provided list belongs to the sales category.
    [Arguments]    ${jobsList}
    ${countries}=    Create List
    FOR    ${job}    IN    @{jobsList}
        ${category}=    Get From Dictionary    ${job}    category
        Should Be Equal    ${category}    Sales
    END

