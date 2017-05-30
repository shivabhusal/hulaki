require 'pry'

path = File.expand_path('../hulaki/', __FILE__)
Dir["#{path}/**/*.rb"].each{ |f| require f }
