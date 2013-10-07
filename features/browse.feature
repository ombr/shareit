# language: en
Feature: Browsing post
  In order to navigate through the files.
  As a loggued in user
  I want to be abble to navigate and see my files.
  @wip
  Scenario: I can click next and previous on my files.
    Given I am loggued in
    When I import theses files :
      |/2013/2013-09-14_First_post/image1.jpg|/spec/fixtures/fujifilm-mx1700.jpg|
      |/2013/2013-09-14_First_post/image2.jpg|/spec/fixtures/fujifilm-dx10.jpg|
      |/2013/2013-09-14_First_post/image3.jpg|/spec/fixtures/canon-ixus.jpg|
    And when I go to my first post
    Then I should see my image in this order:
      |image1.jpg|
      |image2.jpg|
      |image3.jpg|
    When I click on the first image
    Then I should see the item "/2013/2013-09-14_First_post/image1.jpg"
    When click on next
    Then I should see the item "/2013/2013-09-14_First_post/image2.jpg"
    When click on next
    Then I should see the item "/2013/2013-09-14_First_post/image3.jpg"
    When click on previous
    Then I should see the item "/2013/2013-09-14_First_post/image2.jpg"
    When click on previous
    Then I should see the item "/2013/2013-09-14_First_post/image1.jpg"
