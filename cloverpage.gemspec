# frozen_string_literal: true

require_relative 'app/config/app'

Gem::Specification.new do |s|
  s.name = 'cloverpage'
  s.version = AppDefaultVaribles::default_version::STRING
  s.platform = Gem::Platform::RUBY
  s.required_ruby_version = '>= 2.7.0'
  s.authors = ['Codehyouka']
  s.description = <<~DESCRIPTION
    Cloverpage is a static code analyzer that supports different language at your choice
  DESCRIPTION

  s.email = 'cloverpage@googlegroups.com'
  s.files = Dir.glob('{assets,config,lib}/**/*', File::FNM_DOTMATCH)
  s.bindir = 'exe'
  s.executables = ['cloverpage']
  s.extra_rdoc_files = ['LICENSE.txt', 'README.md']
  s.homepage = 'https://github.com/fonipts/cloverpage'
  s.licenses = ['MIT']
  s.summary = 'Automatic Ruby code style checking tool.'

  s.metadata = {
    'homepage_uri' => 'https://cloverpage.codehyouka.xyz/',
    'changelog_uri' => "https://github.com/fonipts/cloverpage/releases/tag/v#{AppDefaultVaribles::default_version::STRING}",
    'source_code_uri' => 'https://github.com/fonipts/cloverpage/',
    'documentation_uri' => "https://cloverpage.codehyouka.xyz/doc/#changelog_{AppDefaultVaribles::default_version}/",
    'bug_tracker_uri' => 'https://github.com/fonipts/cloverpage/issues',
    'rubygems_mfa_required' => 'true'
  }

  s.add_dependency('json', '~> 2.3')
  s.add_dependency('colorize', '>= 1.1')
end