Gem::Specification.new do |s|
  s.name          = 'id'
  s.version       = '2.0.0'
  s.date          = '2013-03-28'
  s.summary       = "Simple models based on hashes"
  s.description   = "Developed at On The Beach Ltd. Contact russell.dunphy@onthebeach.co.uk"
  s.authors       = ["Russell Dunphy", "Radek Molenda"]
  s.email         = ['rssll@rsslldnphy.com', 'radek.molenda@gmail.com']
  s.files         = `git ls-files`.split($\)
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ["lib"]
  s.homepage      = 'http://github.com/onthebeach/id'

  s.add_dependency "optional"
  s.add_dependency "money"
  s.add_dependency "activesupport"
  s.add_dependency "i18n"
  s.add_dependency "json"

  s.add_development_dependency "rspec"
  s.add_development_dependency "simplecov"
  s.add_development_dependency "rake", "~> 10.5.0"

end
