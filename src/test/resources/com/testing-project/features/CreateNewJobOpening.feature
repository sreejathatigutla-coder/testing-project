
@feature_create_new_job_opening
Feature: CreateNewJobOpening

  Background: 
    Given the user is logged into the application

  @view_job_openings
  Scenario Outline: Create New Job Opening
    When the user clicks on the Job Openings menu item in the application
    And the user waits for the Job Opening screen to load
    Then the Job Opening page is displayed
    And the Add Job Opening button is visible and clickable

    Examples:
      |  |

  @add-job-opening
  Scenario Outline: Create New Job Opening
    When the user clicks on the "Add Job Opening" button
    Then the Create New Job Opening form is displayed
    And all required fields are present

    Examples:
      | Job Title   | Job Description | Department | Location  |
      | Software Dev| Develops software| IT         | New York  |

  @valid-job-opening
  Scenario Outline: Create New Job Opening
    Given the user is on the Create Job Opening Page
    When I enter "<job_title>"
    And I enter "<job_description>"
    And I select "<department>" from the dropdown
    And I enter "<location>"
    And I click the "Save" button
    Then a success message is displayed confirming the job opening creation
    And the new job opening appears in the Job Openings listing

    Examples:
      | job_title         | job_description                                                                                          | department  | location  |
      | Software Engineer  | Develop and maintain software applications. Collaborate with cross-functional teams to define, design, and ship new features. | Engineering  | New York  |

  @required_field_validation
  Scenario Outline: Create New Job Opening
    Given the job title is "<job_title>"
    And I enter the job description "<job_description>"
    And I select the department "<department>"
    And I enter the location "<location>"
    When the user clicks the "Save" button
    Then an error message is displayed indicating that the Job Title is required
    And the job opening is not created

    Examples:
      | job_title | job_description                                                   | department | location    |
      |           | A challenging position that requires strong analytical skills and teamwork. | Engineering | New York    |

  @create-job-opening
  Scenario Outline: Create New Job Opening
    Given the user is on the Create Job Opening Page
    When I enter "<job_title>"
    And I enter "<job_description>"
    And I select "<department>"
    And I leave optional fields empty
    And I click the "Save" button
    Then a success message is displayed confirming the job opening creation
    And the new job opening appears in the Job Openings listing with only the filled fields

    Examples:
      | job_title            | job_description                      | department   |
      | Software Engineer    | Develop and maintain software applications. | Engineering  |

  @cancel_job_creation
  Scenario Outline: Create New Job Opening
    Given the user is on the Create Job Opening Page
    When the user enters valid details in the form
    And the user clicks the "Cancel" button
    Then the user is redirected back to the Job Openings listing
    And no new job opening is created

    Examples:
      | title                     | description                                                                 |
      | Create New Job Opening    | Verify that the user can cancel the job opening creation process and return to the Job Openings listing without saving. |

  @edit_job_opening
  Scenario Outline: Create New Job Opening
    When the user clicks on the newly created job opening
    And the user clicks the "Edit" button
    And the user modifies the Job Description
    And the user clicks the "Save" button
    Then a success message is displayed confirming the job opening update
    And the updated job opening details are reflected in the Job Openings listing

  Examples:
    | job_description          |
    | Updated Job Description  |

  @view_job_opening
  Scenario Outline: Create New Job Opening
    When the user clicks on the newly created job opening
    Then the job opening details are displayed correctly
    And all fields (Job Title, Job Description, Department, Location) are visible and accurate

    Examples:
      | job_title       | job_description       | department | location   |
      | Software Engineer| Develop software      | IT         | New York   |

  @filter_job_openings
  Scenario Outline: Create New Job Opening
    Given the user is on the Job Openings listing
    When the user clicks on the filter options
    And the user selects <Department> from the filter dropdown
    And the user clicks the Apply Filter button
    Then the Job Openings listing updates to show only job openings that match the selected Department
    And the filter criteria are displayed on the page

    Examples:
      | Department  |
      | Engineering  |
      | Marketing    |

  @sort_job_opening
  Scenario Outline: Create New Job Opening
    When the user clicks on the sorting options
    And selects the sorting order "<sorting_order>"
    Then the Job Openings listing updates to show job openings sorted by the selected criteria
    And the sorting order is visually indicated on the page

    Examples:
      | sorting_order |
      | Ascending     |
      | Descending    |

  @job-openings-pagination
  Scenario Outline: Create New Job Opening
    Given the user observes the pagination controls at the bottom of the listing
    When the user clicks on the next page button
    Then the Job Openings listing updates to show the next set of job openings
    And the pagination controls reflect the current page number

    Examples:
      | title                     |
      | Create New Job Opening    |

  @job_opening_creation
  Scenario Outline: Create New Job Opening
    When I create a new job opening with valid details
    And I click the Save button
    Then a confirmation message is displayed indicating the job opening was created successfully
    And the user is redirected to the Job Openings listing

    Examples:
      | valid_details |
      | valid_data    |

  @duplicate-job-title
  Scenario Outline: Create New Job Opening with Duplicate Job Title
    Given the user enters "<job_title>"
    And the user fills in the Job Description "<job_description>"
    And the user selects the Department "<department>"
    And the user enters the Location "<location>"
    When the user clicks the "Save" button
    Then an error message is displayed indicating that the Job Title already exists
    And the job opening is not created

    Examples:
      | job_title             | job_description                                                                                                                  | department | location  |
      | Duplicate Job Title   | This is a job description that provides details about the responsibilities and requirements of the position. It should be comprehensive and clear. | Sales      | New York  |

  @max-character-limit
  Scenario Outline: Create New Job Opening with Exceeded Job Description Limit
    Given the user enters a valid Job Title "<jobTitle>"
    And the user enters a Job Description "<jobDescription>"
    And the user selects a valid Department "<department>"
    And the user enters a valid Location "<location>"
    When the user clicks the "Save" button
    Then an error message is displayed indicating that the Job Description exceeds the maximum length
    And the job opening is not created

    Examples:
      | jobTitle           | jobDescription                                                                 | department  | location   |
      | Software Engineer   | aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa | Engineering | New York   |

  @invalid-location
  Scenario Outline: Create New Job Opening
    Given I enter a valid Job Title "<job_title>"
    And I enter a valid Job Description "<job_description>"
    And I select a valid Department "<department>"
    And I enter an invalid Location "<location>"
    When I click the "Save" button
    Then an error message is displayed indicating that the Location format is invalid
    And the job opening is not created

    Examples:
      | job_title           | job_description                       | department  | location          |
      | Software Engineer    | Develop and maintain software applications. | Engineering | @InvalidLocation! |

  @invalid_department
  Scenario Outline: Create New Job Opening with Invalid Department
    Given the user enters a valid Job Title "<job_title>"
    And the user enters a valid Job Description "<job_description>"
    And the user selects an invalid Department "<department>"
    And the user enters a valid Location "<location>"
    When the user clicks the "Save" button
    Then an error message is displayed indicating that the selected Department is invalid

    Examples:
      | job_title                | job_description                                                              | department | location   |
      | Software Engineer        | Develop and maintain software applications, ensuring high quality and performance. | Invalid Department | New York   |

  @invalid-job-title
  Scenario Outline: Create New Job Opening with Invalid Job Title
    Given the user enters a Job Title with invalid characters "<job_title>"
    And the user enters a valid Job Description "<job_description>"
    And the user selects a valid Department "<department>"
    And the user enters a valid Location "<location>"
    When the user clicks the "Save" button
    Then an error message should be displayed indicating that the Job Title contains invalid characters
    And the job opening should not be created

    Examples:
      | job_title   | job_description                                         | department   | location   |
      | !@#$%^&*()  | This is a valid job description for the position.     | Engineering   | New York   |

  @missing-required-fields
  Scenario Outline: Create New Job Opening with Missing Required Fields
    Given the user leaves all required fields empty
    When the user clicks the "Save" button
    Then error messages are displayed for all required fields indicating they must be filled
    And the job opening is not created

    Examples:
      |  |
      |  |

  @valid-job-opening
  Scenario Outline: Create New Job Opening
    Given the user enters a valid Job Title "<job_title>"
    And the user enters a Job Description with the maximum allowed characters "<job_description>"
    And the user selects a valid Department "<department>"
    And the user enters a valid Location "<location>"
    When the user clicks the "Save" button
    Then a success message should be displayed confirming the job opening creation
    And the new job opening should appear in the Job Openings listing with the correct details

    Examples:
      | job_title         | job_description | department   | location    |
      | Software Engineer  | a * 100         | Engineering  | New York    |

  @valid-job-creation
  Scenario Outline: Create New Job Opening
    Given the user is on the Create Job Opening Page
    When I enter "<job_title>"
    And I enter "<job_description>"
    And I select "<department>"
    And I enter "<location>"
    And I click the "Save" button
    Then a success message is displayed confirming the job opening creation
    And the new job opening appears in the Job Openings listing with the correct details

    Examples:
      | job_title | job_description   | department  | location    |
      | Dev       | Develop software   | Engineering | New York    |
