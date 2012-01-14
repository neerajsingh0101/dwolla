require 'simplecov'
SimpleCov.start

$:.unshift File.expand_path('..', __FILE__)
$:.unshift File.expand_path('../../lib', __FILE__)

require 'dwolla'
require 'rspec'
require 'webmock/rspec'
require 'support/helpers'
