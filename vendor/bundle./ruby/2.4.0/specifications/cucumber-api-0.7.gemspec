# -*- encoding: utf-8 -*-
# stub: cucumber-api 0.7 ruby lib

Gem::Specification.new do |s|
  s.name = "cucumber-api".freeze
  s.version = "0.7"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Ha Duy Trung".freeze]
  s.date = "2018-08-29"
  s.description = "cucumber-api allows API JSON response validation and verification in BDD style.".freeze
  s.email = ["haduytrung@gmail.com".freeze]
  s.homepage = "https://github.com/hidroh/cucumber-api".freeze
  s.licenses = ["Apache-2.0".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.3.0".freeze)
  s.rubygems_version = "3.0.8".freeze
  s.summary = "API validator with Cucumber".freeze

  s.installed_by_version = "3.0.8" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<addressable>.freeze, ["= 2.5"])
      s.add_runtime_dependency(%q<cucumber>.freeze, ["~> 3.1.0"])
      s.add_runtime_dependency(%q<jsonpath>.freeze, ["~> 0.8"])
      s.add_runtime_dependency(%q<rest-client>.freeze, ["~> 2.0.2"])
      s.add_runtime_dependency(%q<json-schema>.freeze, ["~> 2.8.0"])
    else
      s.add_dependency(%q<addressable>.freeze, ["= 2.5"])
      s.add_dependency(%q<cucumber>.freeze, ["~> 3.1.0"])
      s.add_dependency(%q<jsonpath>.freeze, ["~> 0.8"])
      s.add_dependency(%q<rest-client>.freeze, ["~> 2.0.2"])
      s.add_dependency(%q<json-schema>.freeze, ["~> 2.8.0"])
    end
  else
    s.add_dependency(%q<addressable>.freeze, ["= 2.5"])
    s.add_dependency(%q<cucumber>.freeze, ["~> 3.1.0"])
    s.add_dependency(%q<jsonpath>.freeze, ["~> 0.8"])
    s.add_dependency(%q<rest-client>.freeze, ["~> 2.0.2"])
    s.add_dependency(%q<json-schema>.freeze, ["~> 2.8.0"])
  end
end
