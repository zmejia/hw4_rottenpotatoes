# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
     Movie.create(movie)
  end
  #flunk "Unimplemented"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  titles = page.body 
  assert titles.index(e1) < titles.index(e2)
end

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
    rating_list.split(",").each do |field|
        field = field.strip
        if uncheck == "uncheck"
            uncheck("ratings_#{field}")
        else
            check("ratings_#{field}")
        end
    end
end


Then /^I should see 'PG' and 'R' movies$/ do
 # express the regexp above with the code you wish you had
  page.body.should match(/<td>R<\/td>/)
  page.body.should match(/<td>PG<\/td>/)
end

Then /^I should not see 'PG\-(\d+)' and 'G' movies$/ do |r|
 # express the regexp above with the code you wish you had
  page.body.should match(/<td>G<\/td>/)
  page.body.should match(/<td>PG-13<\/td>/)
end

Then /^I should see all of the movies$/ do 
    rows = page.all("table#movies tbody tr td[1]").map {|t| t.text}
     assert rows.size == Movie.all.count 
end

Then /^the director of "([^"]*)" should be "([^"]*)"$/ do |movie, director|
  page.should have_content(movie)
  page.should have_content(director)
end

And /^(?:|I )should see "([^"]*)" has no diretor info$/ do |text|
  if page.respond_to? :should
    page.should have_content(text)
  else
    assert page.has_content?(text)
  end
end






