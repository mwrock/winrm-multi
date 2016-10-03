lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'winrm/multi/version'

Gem::Specification.new do |spec|
  spec.name          = 'winrm-multi'
  spec.version       = WinRM::Multi::VERSION
  spec.authors       = ['Matt Wrock']
  spec.email         = ['matt@mattwrock.com']

  spec.summary       = 'Control multiple WinRM shells via a single interface'
  spec.homepage      = 'https://github.com/WinRb/winrm-multi'
  spec.license       = 'Apache-2.0'

  spec.files = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'winrm', '~> 2.0'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0.28'
end
