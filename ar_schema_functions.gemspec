# frozen_string_literal: true

require_relative 'lib/ar_schema_functions/version'

Gem::Specification.new do |spec|
  spec.name          = 'ar_schema_functions'
  spec.version       = ArSchemaFunctions::VERSION
  spec.authors       = ['Dave Allie']
  spec.email         = ['dave@visibuild.com.au']

  spec.summary       = 'Populate schema.rb with stored SQL functions'
  spec.homepage      = 'https://github.com/visibuild/ar_schema_functions'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.5.0')

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/visibuild/ar_schema_functions'
  spec.metadata['changelog_uri'] = 'https://github.com/visibuild/ar_schema_functions/blob/master/CHANGELOG.md'

  spec.files = Dir['lib/**/*'] + %w[Gemfile ar_schema_functions.gemspec]
  spec.require_paths = ['lib']

  spec.add_dependency 'activerecord', '>= 4.0.0', '< 7.0.0'
end
