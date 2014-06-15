#!/usr/bin/ruby
$: << "."
require 'McMyAdminAPI'

c = CodeForKids::McMyAdminAPI.new('minecraft.codeforkids.ca')
c.login(ENV['MC_USERNAME'], ENV['MC_PASSWORD'])

# Add code here
