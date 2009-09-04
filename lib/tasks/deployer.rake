task :deployer => [:clean] do
  ruby "c:/ruby/bin/tar2rubyscript c:/Projects/HacmeCasino/"
  ruby "c:/ruby/bin/rubyscript2exe ../HacmeCasino.rb"
end
 
task :clean do
 puts "Clearing Session"
 Rake::Task["tmp:clear"].invoke
 puts "Clearing Logs"
 Rake::Task["log:clear"].invoke
 puts "Refreshing Database"
 File.copy("db/clean_hacmecasino_development.db", "db/hacmecasino_development.db")
end