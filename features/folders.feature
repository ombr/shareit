# language: en
Feature: Folder parsing
  In order to display the content on the site
  As a loggued in user
  I want to import content (files and directories)
  I should see posts ready to share on the site
  Scenario: I import some files and it displays posts
    Given I am loggued in
    When I import theses files :
      |/2013/2013-09-14_First_post/image1.jpg|/spec/fixtures/image.jpg|
      |/2013/2013-09-14_First_post/random_name.jpg|/spec/fixtures/image.jpg|
      |/2013/2013-09-14_First_post/Another random_name.jpg|/spec/fixtures/image.jpg|
    Then I should see my post "First post".
