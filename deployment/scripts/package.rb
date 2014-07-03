
application_directory = `pwd`
puts "Packaging directory #{application_directory}"
`cd #{application_directory} && bundle install && tar -zcvf package-$(date() +"%m-%d-%Y").tar.gz .`