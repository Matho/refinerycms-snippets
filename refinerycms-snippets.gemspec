# Encoding: UTF-8
$:.push File.expand_path('../lib', __FILE__)
require 'refinery/snippets/version'

version = Refinery::Snippets::VERSION.to_s

Gem::Specification.new do |s|
  s.platform          = Gem::Platform::RUBY
  s.name              = %q{refinerycms-snippets}
  s.version           = version
  s.description       = %q{Ruby on Rails Snippets engine for Refinery CMS}
  s.date              = %q{2011-12-14}
  s.summary           = %q{Html snippets for Refinery CMS page}
  s.authors           = ['Marek L.', 'Rodrigo Garcia Suarez']
  s.email             = %q{nospam.keram@gmail.com}
  s.require_paths     = %w(lib)

  s.files             = `git ls-files`.split("\n")
  s.test_files        = `git ls-files -- spec/*`.split("\n")
  
  # Runtime dependencies
  s.add_dependency    'refinerycms-pages', '~> 2.0.0' 

end
