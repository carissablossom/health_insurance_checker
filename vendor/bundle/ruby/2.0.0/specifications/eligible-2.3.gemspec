# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "eligible"
  s.version = "2.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Andy Brett"]
  s.date = "2013-08-18"
  s.description = "Eligible is a developer-friendly way to process health care eligibility checks. Learn more at https://eligibleapi.com"
  s.email = ["andy@andybrett.com"]
  s.homepage = "https://eligibleapi.com/"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "2.0.14.1"
  s.summary = "Ruby wrapper for the Eligible API"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<mocha>, [">= 0"])
      s.add_development_dependency(%q<shoulda>, [">= 0"])
      s.add_development_dependency(%q<test-unit>, [">= 0"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_runtime_dependency(%q<rest-client>, ["~> 1.4"])
      s.add_runtime_dependency(%q<multi_json>, ["< 2", ">= 1.0.4"])
    else
      s.add_dependency(%q<mocha>, [">= 0"])
      s.add_dependency(%q<shoulda>, [">= 0"])
      s.add_dependency(%q<test-unit>, [">= 0"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<rest-client>, ["~> 1.4"])
      s.add_dependency(%q<multi_json>, ["< 2", ">= 1.0.4"])
    end
  else
    s.add_dependency(%q<mocha>, [">= 0"])
    s.add_dependency(%q<shoulda>, [">= 0"])
    s.add_dependency(%q<test-unit>, [">= 0"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<rest-client>, ["~> 1.4"])
    s.add_dependency(%q<multi_json>, ["< 2", ">= 1.0.4"])
  end
end
