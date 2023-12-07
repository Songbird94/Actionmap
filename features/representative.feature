Feature: Creating a Representative

Background: Create a representative
  Given I create the following representative:
    | name | title | ocdid | address | city | state | zip | political_party | photo_url |
    | Noel | title | ocdid | line1 | Manchester | State | 94704 | Democratic | photo.png |

Scenario: Show the representative view 
  When I go to the "Noel" profile page
  And I should see the representative's photo with src "photo.png"
  And I should see "Noel"
  And I should see "title"
  And I should see "line1"
  And I should see "Manchester"
  And I should see "State"
  And I should see "94704"
  And I should see "Democratic"
