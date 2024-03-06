Resource    ../../resources/page_objects/careers.robot

*** Keywords ***
Confirm Search
    Page Should Contain Element     ${searchButton}
    Click Element       ${searchButton}

Verify Global Search Initial State
    Page Should Contain Element     ${searchJobTitleBox}
    ${jobTitleTextBoxValue}=    Get Value    ${searchJobTitleBox}
    Should Be Equal     ${jobTitleTextBoxValue}     ${EMPTY}
    Page Should Contain Element     ${searchLocationBox}
    ${locationTextBoxValue}=    Get Value    ${searchLocationBox}
    Should Be Equal     ${locationTextBoxValue}     ${EMPTY}
    Page Should Contain Element     ${searchButton}

Verify Job Categories Dropdown
    Click Element       ${searchJobTitleFilter}
    Page Should Contain Element     ${jobCategoriesDropdown}

Verify Job Category Is Listed
    [Arguments]     ${searchedCategory}
    ${jobCategoriesNames}=    Create List
    Wait Until Page Contains Element    ${categoriesItems}
    ${categories}=       Get WebElements     ${categoriesItems}
    FOR    ${category}    IN    @{categories}
        ${foundCategoryName}=    Get Element Attribute    ${category}    data-ph-at-data-text
        Append to list      ${jobCategoriesNames}       ${foundCategoryName}
    END
    Should Contain      ${jobCategoriesNames}       ${searchedCategory}

Execute Comprehensive Job Search
    ${jobsFound}=   Verify Search Returns Multiple Jobs
    ${pages}=   Verify Pagination Is Correct      ${jobsFound}
    ${jobsList}=    Get Filtered Jobs    ${pages}
    RETURN      ${jobsList}

Verify Search Returns Multiple Jobs
    Wait Until Element Is Visible    ${jobsListCount}
    Log     ${jobsListCount}
    ${numberOfFoundJobs}=    Get Element Attribute   ${jobsListCount}   data-ph-at-count
    ${numberOfFoundJobs}=    Convert To Integer    ${numberOfFoundJobs}
    Should Be True    ${numberOfFoundJobs} > 1    msg=The number of jobs should be at least two but was ${numberOfFoundJobs}.
    RETURN    ${numberOfFoundJobs}

Verify Pagination Is Correct
    [Arguments]     ${jobsFound}
    ${expectedNumberOfPages}=    Evaluate    math.ceil(${jobsFound} / 10.0)    modules=math
    ${pagesLinks}=       Get WebElements     ${paginationElement}
    ${foundNumberOfPages}=      Get Length      ${pagesLinks}
    Should Be Equal    ${expectedNumberOfPages}    ${foundNumberOfPages}
    RETURN      ${foundNumberOfPages}

Get Filtered Jobs
    [Arguments]     ${numberOfPages}
    ${finalJobsList}=    Create List
    ${currentPageJobsList}=    Get Jobs In Current Page
    Append To List      ${finalJobsList}    @{currentPageJobsList}
    ${moreThanOnePage}=    Evaluate    ${numberOfPages} > 1
    Run Keyword If    ${moreThanOnePage}    Run Keyword    For Loop To Get Jobs From All Pages    ${numberOfPages}    ${finalJobsList}
    LOG     ${finalJobsList}
    RETURN  ${finalJobsList}

For Loop To Get Jobs From All Pages
    [Arguments]    ${numberOfPages}    ${finalJobsList}
    FOR     ${page}     IN RANGE    1    ${numberOfPages}
        Wait Until Element Is Visible       ${nextPageButton}
        Click Element       ${nextPageButton}
        ${currentPageJobsList}=    Get Jobs In Current Page
        Append To List      ${finalJobsList}    @{currentPageJobsList}
    END
    RETURN    ${finalJobsList}

Get Jobs In Current Page
    ${jobs}=    Get Webelements    ${jobsListItem}
    ${jobsDetailsList}=    Create List

    FOR    ${job_element}    IN    @{jobs}
        ${title}=    Get Element Attribute    ${job_element}    data-ph-at-job-title-text
        ${location}=    Get Element Attribute    ${job_element}    data-ph-at-job-location-text
        ${category}=    Get Element Attribute    ${job_element}    data-ph-at-job-category-text
        ${type}=    Get Element Attribute   ${job_element}     data-ph-at-job-type-text
        ${jobDetails}=    Create Dictionary    title=${title}    location=${location}    category=${category}    type=${type}
        Append To List    ${jobsDetailsList}    ${jobDetails}
    END
    RETURN      ${jobsDetailsList}


Verify Target Category Is Selected
    Wait Until Element Is Visible   css=ppc-content.ppc-text.ppc-content[data-ph-at-id='description-text']
    ${text}=    Get Text    css=ppc-content.ppc-text.ppc-content[data-ph-at-id='description-text']
    Should Be Equal     ${text}     Sales Job Opportunities





