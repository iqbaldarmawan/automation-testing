# -*- encoding: utf-8 -*-
# stub: queryparams 0.0.3 ruby lib

Gem::Specification.new do |s|
  s.name = "queryparams".freeze
  s.version = "0.0.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Simen Svale Skogsrud".freeze]
  s.date = "2011-10-31"
  s.description = " It supports hashes, arrays, nested hashes and arrays of hashes and all combinations thereof.".freeze
  s.email = ["simen@bengler.no".freeze]
  s.homepage = "".freeze
  s.rubygems_version = "3.0.8".freeze
  s.summary = "A straight forward gem to convert ruby hashes and arrays to http query strings.".freeze

  s.installed_by_version = "3.0.8" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>.freeze, [">= 0"])
    else
      s.add_dependency(%q<rspec>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<rspec>.freeze, [">= 0"])
  end
end
