Then(/^I should receive the json:$/) do |json|
  page.body.should == json.squish.delete(" ")
end