# Just Eat Takeaway Careers - Robot Framework QA Automation

This README file provides information about the Robot Framework test suite for Just Eat Takeaway careers page.
## Overview

This project serves as an automation tool to test the career section on the Just Eat Takeaway platform (https://careers.justeattakeaway.com/global/en/home). It aims to ensure accuracy and consistency in job search functionality and refines results based on specific criteria.


The test performs the following steps:

    Search by Job Title ("Test") without Location:
        Verifies search results include positions from multiple locations.
        Refines search to "Netherlands" and ensures results are only from that country.

    Search by Job Category ("Sales") and Refine by Location ("Germany"):
        Verifies "Sales" is selected and the initial search result count is accurate.
        Refines search to "Germany" and ensures category remains "Sales" and results match the criteria.

## Prerequisites

    Robot Framework
    Python 3.10 
    Pipenv 
    Pip
    Chrome WebDriver (If Using Chrome)

## Project setup
    
1. Ensure you have the necessary libraries installed.: 
	Login to terminal
    ```
        python3 --version
        pip3 --version
        pipenv --version
    ```
    
    2. If pipenv is not installed.
    
    ```
    pip3 install pipenv 
    ```
    
    3. Install project's dependencies:
    ```
    pipenv install
    ```
    4. Execute a pipenv shell / Activate virtual environment:
    ```
    pipenv shell
    ```
    5. Run the below command to check if the requirement for robotframework is not broken:
    ```
    pip check robotframework
    ```

    Open a terminal in the project's tests source directory. 
    ```
    cd src/tests/careers/
    ```

    Run the following command to execute the tests:
    ```
   robot --outputdir << SPECIFY OUTPUT DIRECTORY HERE >> << TESTCASE.robot >>
    ```


## Project Structure

The project is organized into the following directories:

    Pipfile: Specifies project dependencies and their versions.
    Pipfile.lock: Locks down the exact versions of dependencies used.
    Readme.md (current file): Provides documentation about the project.
    run.py: Wrapper script to execute the tests.
    src: Contains the source code for the test suite.
        resources: Stores reusable resources for the tests.
            keywords: Contains reusable keyword definitions for common actions.
                custom_keywords.robot: Custom keywords specific to this project.
                open_browser.robot: Keywords for opening the browser and interacting with the careers page.
            page_objects: Contains Robot Framework page object definitions for the careers page and potentially other relevant pages.
                careers.robot: Page object definitions for the careers page.
                search_results.robot: Page object definitions for the search results page.
        tests: Contains the actual test cases.
            careers: Subdirectory containing test cases related to the careers page.

This README file serves as a starting point for understanding and running the test suite. For further details or modifications, refer to the provided Robot Framework code and explore the referenced resources.