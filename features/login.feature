# language: en
@wip
Feature: Login
  In order to manage my informations (credentials and friends)
  As a user of the website
  I want to be able to create an account easily.
  Scenario: I register
    Given I am a guest
    When I visit the home page
    And click on register
    And fill a username, email and password and submit the form
    Then I should be loggued in.
    And see a warning about my confirmation
    And receive a confirmation email.
  @javascript
  Scenario: I login with username
    Given I have an account
    When I visit the home page
    And click on log in
    And fill my username and password
    Then I should be loggued in.
