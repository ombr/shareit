# language: en
Feature: Import
  In order to add content to the site
  As a loggued in user
  I want to import content
  Scenario: Import box.com content
    Given I am loggued in
    When I import my box.com account
    And I wait 5 seconds
    Then I should see my hello_world.txt document
