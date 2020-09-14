# -*- encoding: utf-8 -*-
# stub: rtesseract 3.1.2 ruby lib

Gem::Specification.new do |s|
  s.name = "rtesseract".freeze
  s.version = "3.1.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Danilo Jeremias da Silva".freeze]
  s.bindir = "exe".freeze
  s.date = "2020-08-23"
  s.description = "Ruby library for working with the Tesseract OCR.".freeze
  s.email = ["dannnylo@gmail.com".freeze]
  s.homepage = "http://github.com/dannnylo/rtesseract".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.0.8".freeze
  s.summary = "Ruby library for working with the Tesseract OCR.".freeze

  s.installed_by_version = "3.0.8" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>.freeze, ["~> 2"])
      s.add_development_dependency(%q<coveralls>.freeze, [">= 0"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
      s.add_development_dependency(%q<rspec>.freeze, [">= 0"])
    else
      s.add_dependency(%q<bundler>.freeze, ["~> 2"])
      s.add_dependency(%q<coveralls>.freeze, [">= 0"])
      s.add_dependency(%q<rake>.freeze, [">= 0"])
      s.add_dependency(%q<rspec>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<bundler>.freeze, ["~> 2"])
    s.add_dependency(%q<coveralls>.freeze, [">= 0"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<rspec>.freeze, [">= 0"])
  end
end
