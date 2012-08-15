$:.push File.expand_path('../lib', __FILE__)

require 'scalpel'

Gem::Specification.new do |s|
  s.name        = 'scalpel'
  s.version     = Scalpel::VERSION
  s.authors     = ['Louis Mullie']
  s.email       = ['louis.mullie@gmail.com']
  s.homepage    = 'https://github.com/louismullie/scalpel'
  s.summary     = %q{ A fast and accurate rule-based sentence segmentation tool for Ruby. }
  s.description = %q{ Scalpel is a sentence segmentation tool for Ruby. It allows you to split a text into an array of sentences. It is simple, lightweight, blazing fast and does not require any domain-specific training. It works well even in the face of ill-formatted texts. }
  
  # Add all files.
  s.files = Dir['lib/**/*'] + ['README.md', 'LICENSE']
    
end