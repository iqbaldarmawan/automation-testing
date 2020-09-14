# -*- encoding: utf-8 -*-
# stub: to_regexp 0.2.1 ruby lib

Gem::Specification.new do |s|
  s.name = "to_regexp".freeze
  s.version = "0.2.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Seamus Abshere".freeze]
  s.date = "2013-05-21"
  s.description = "Provides String#to_regexp, for example if you want to make regexps out of a CSV you just imported.".freeze
  s.email = ["seamus@abshere.net".freeze]
  s.homepage = "https://github.com/seamusabshere/to_regexp".freeze
  s.rubygems_version = "3.0.8".freeze
  s.summary = "Provides String#to_regexp".freeze

  s.installed_by_version = "3.0.8" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<ensure-encoding>.freeze, [">= 0"])
      s.add_development_dependency(%q<yard>.freeze, [">= 0"])
    else
      s.add_dependency(%q<ensure-encoding>.freeze, [">= 0"])
      s.add_dependency(%q<yard>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<ensure-encoding>.freeze, [">= 0"])
    s.add_dependency(%q<yard>.freeze, [">= 0"])
  end
end
