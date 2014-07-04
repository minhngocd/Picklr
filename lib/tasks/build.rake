
PACKAGE_DIRECTORY='/tmp'

namespace :build do

  desc 'clean package'
  task :clean do
    puts "Cleaning packages from directory #{PACKAGE_DIRECTORY}"
    `rm -f #{PACKAGE_DIRECTORY}/package-*.tar.gz`
    puts "*"*50
  end

  desc 'bundle install'
  task :bundle do
    puts `bundle install`
    puts "*"*50
  end

  desc 'package the application'
  task :package => [:clean, :bundle] do
    current_directory = `pwd`
    puts "Packaging directory #{current_directory}"
    `tar -zcf #{PACKAGE_DIRECTORY}/package-$(date +"%m-%d-%Y").tar.gz \
      --exclude=".git/" \
      --exclude=".idea/" \
      --exclude="deployment/" \
      --exclude=".rvmrc" \
    .`
    puts "*"*50
  end

end
