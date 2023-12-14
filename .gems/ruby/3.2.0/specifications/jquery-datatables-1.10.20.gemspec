# -*- encoding: utf-8 -*-
# stub: jquery-datatables 1.10.20 ruby lib

Gem::Specification.new do |s|
  s.name = "jquery-datatables".freeze
  s.version = "1.10.20".freeze

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["mkhairi".freeze]
  s.date = "2019-11-08"
  s.description = "Include jQuery DataTables in asset pipeline with ease".freeze
  s.email = ["mkhairi@labs.my".freeze]
  s.homepage = "https://github.com/mkhairi/jquery-datatables".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.4.22".freeze
  s.summary = "Jquery DataTables web assets for Rails, etc.".freeze

  s.installed_by_version = "3.4.22".freeze if s.respond_to? :installed_by_version

  s.specification_version = 4

  s.add_development_dependency(%q<jquery-rails>.freeze, ["~> 3.1".freeze])
  s.add_development_dependency(%q<bundler>.freeze, ["~> 1.7".freeze])
  s.add_development_dependency(%q<rake>.freeze, ["~> 10.0".freeze])
end
