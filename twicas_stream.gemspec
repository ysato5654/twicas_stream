# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'twicas_stream/version'

Gem::Specification.new do |spec|
  spec.name          = 'twicas_stream'
  spec.version       = TwicasStream::VERSION
  spec.authors       = ['Yuya Sato']
  spec.email         = ['ysato.5654@gmail.com']

  spec.summary       = 'Ruby interface to TwitCasting API'
  spec.description   = spec.description
  spec.homepage      = 'https://github.com/ysato5654/twicas_stream'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

#require 'active_support/inflector'
  spec.add_dependency 'activesupport', '~> 5.1.1'
  spec.add_dependency 'curb', '~> 0.9.3'
  spec.add_dependency 'json', '~> 2.1.0'

  spec.add_development_dependency 'bundler', '~> 1.15'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
