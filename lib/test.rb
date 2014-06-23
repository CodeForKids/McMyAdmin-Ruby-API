#!/usr/bin/ruby
$: << "."
require 'McMyAdminAPI'

c = CodeForKids::McMyAdminAPI.new('minecraft.codeforkids.ca')
c.login(ENV['MC_USERNAME'], ENV['MC_PASSWORD'])
c.add_user_to_group('Code For Kids', 'testing')
# Add code here
