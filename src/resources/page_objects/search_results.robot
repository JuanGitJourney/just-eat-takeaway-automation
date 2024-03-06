*** Variables ***
${subSearchTextBox}      id=sub_search_textbox
${sortSelect}       id=sortselect
${categoryAction}       id=CategoryAccordion
${countryAccordion}     id=CountryAccordion
${cityAccordion}        id=cityAccordion
${typeAccordion}        id=typeAccordion

${contentBlock}     css=div.content-block
${jobsListCount}        css=div.phs-jobs-list-count.au-target[data-ph-at-id='search-page-top-job-count']
${paginationElement}    xpath=//li[contains(@class, 'au-target')]//a[@data-ph-at-id='pagination-page-number-link']

${jobsListItem}        xpath=//li[contains(@class, 'jobs-list-item')]//a[@data-ph-at-id='job-link']

${categoriesItems}       xpath=//li[contains(@class, 'au-target')]//a[@data-ph-at-id='category-link']
${selectedCategory}        css=li.tag[data-ph-at-id='facet-tags-item']

${nextPageButton}       css=a.au-target[aria-label='View next page']

