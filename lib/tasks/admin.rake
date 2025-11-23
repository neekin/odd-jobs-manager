require "io/console"

namespace :admin do
  desc "Create or update an admin. Interactive if USERNAME/PASSWORD not provided."
  task create: :environment do
    username = ENV["USERNAME"]
    password = ENV["PASSWORD"]

    unless username
      print "Admin username: "
      username = STDIN.gets&.strip
    end

    unless password
      print "Password (will not echo): "
      password = STDIN.noecho(&:gets)&.strip
      puts
      print "Confirm password: "
      confirm = STDIN.noecho(&:gets)&.strip
      puts
      if password != confirm
        puts "Passwords do not match. Aborted."
        exit 1
      end
    end

    begin
      AdminManager.create_admin!(username: username, password: password)
      puts "Admin #{username} created/updated successfully."
    rescue => e
      puts "Failed: #{e.message}"
      exit 1
    end
  end

  desc "Reset admin password. Interactive if USERNAME/PASSWORD not provided."
  task reset_password: :environment do
    username = ENV["USERNAME"]
    password = ENV["PASSWORD"]

    unless username
      print "Admin username: "
      username = STDIN.gets&.strip
    end

    unless password
      print "New password (will not echo): "
      password = STDIN.noecho(&:gets)&.strip
      puts
      print "Confirm password: "
      confirm = STDIN.noecho(&:gets)&.strip
      puts
      if password != confirm
        puts "Passwords do not match. Aborted."
        exit 1
      end
    end

    begin
      AdminManager.reset_password!(username: username, password: password)
      puts "Password for #{username} reset successfully."
    rescue => e
      puts "Failed: #{e.message}"
      exit 1
    end
  end
end
