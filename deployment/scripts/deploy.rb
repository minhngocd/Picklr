require 'net/ssh'
require "highline/import"

PACKAGE_PATH = ARGV[0]
USERNAME = ARGV[1]
SERVER = ARGV[2]
PORT = ARGV[3] || 2222

HEALTHCHECK_URL = "localhost:3000"

def clean_artifacts(ssh)
  puts "Cleaning destination folder..."
  ssh.exec! "rm -rf /tmp/picklr/*"
end

def stop_service ssh
  begin
    ssh.exec! "cd /tmp/picklr && kill -9 $(cat tmp/pids/server.pid)"
  rescue
    puts "-"*20
    puts "unable to find pid file... Make sure process is run using script!"
    puts "-"*20
  end

  puts "Waiting for Service to stop..."
  result = :running
  5.times do
    response = ssh.exec! "curl -I #{HEALTHCHECK_URL}"
    if response.include? "Connection refused"
      result = :stopped
      break
    end
    puts "Waiting 2s before rechecking..."
    sleep 2
  end
  exit_script "Unable to stop service!! Try stopping service manually" if result == :running
end

def exit_script message
  puts message
  exit 1
end

def parse_filename filepath
  match = filepath.match(/.*\/(.*).tar.gz/)
  match.captures.first unless match.nil?
end

if ARGV.length < 3 || ARGV.length > 4
  exit_script "Usage: ruby deploy.rb <package path> <username> <server> [optional] <port>"
end


begin

  filename = parse_filename PACKAGE_PATH

  password = ask("SSH password for #{USERNAME}@#{SERVER}: ") { |input| input.echo = false }

  puts "*"*100
  puts "ssh into machine..."
  Net::SSH.start(SERVER, USERNAME, :password => password, :port => PORT) do |ssh|
    puts "ssh success!"

    puts "*"*100
    puts "creating folder structures if not exist..."
    ssh.exec! "mkdir -p /tmp/picklr"

    puts "*"*100
    puts "stopping running service..."
    stop_service ssh

    puts "*"*100
    puts "cleaning old artifacts..."
    clean_artifacts ssh

    puts "*"*100
    puts "copying file to environment..."
    `scp -P #{PORT} #{PACKAGE_PATH} #{USERNAME}@#{SERVER}:/tmp/picklr/ > /dev/tty`

    puts "*"*100
    puts "unzipping archive..."
    ssh.exec! "cd /tmp/picklr && tar -zxf #{filename}.tar.gz" do |channel, stream, line|
      puts line
    end

    puts "*"*100
    puts "Starting service..."
    ssh.exec! "cd /tmp/picklr && sudo gem install bundler && bundle install && rake db:create db:migrate &&rails server -d " do |channel, stream, line|
      puts line
    end

    result = :stopped
    5.times do
      response = ssh.exec! "curl -I #{HEALTHCHECK_URL}"
      if response.include? "200 OK"
        result = :running
        break
      end
      puts "Waiting 2s before rechecking..."
      sleep 2
    end
    if result == :stopped
      exit_script "SERVICE NOT STARTED!!"
    end
    puts "SERVICE IS RUNNING! Have a nice day :)"

  end

rescue Exception => exception
  exit_script exception.inspect
end

