# language: en
Feature: Import
  In order to add content to the site
  As a loggued in user
  I want to import content
  @javascript
  Scenario: Import box.com content
    Given I am loggued in
    When I import my box.com account
    And I Wait for the jobs
    Then I should see my post "First post".
  @javascript
  Scenario: Import facebook contacts
    Given I am loggued in
    When I import my facebook contacts
    And I Wait for the jobs
    Then I should see my list "Super_List"
