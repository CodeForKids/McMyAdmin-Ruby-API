#!/usr/bin/ruby
$: << "."
require 'McMyAdminAPI'

c = CodeForKids::McMyAdminAPI.new('minecraft.codeforkids.ca')
c.login(ENV['MC_USERNAME'], ENV['MC_PASSWORD'])
puts c.get_status()
