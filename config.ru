$: << 'lib'

require 'rubygems'
require 'bundler'
Bundler.require

require 'lib/printel'
run Printel::Server
