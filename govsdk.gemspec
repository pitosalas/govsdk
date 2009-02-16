# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{govsdk}
  s.version = "0.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Pito Salas"]
  s.date = %q{2009-02-13}
  s.description = %q{TODO}
  s.email = %q{rps@salas.com}
  s.files = ["README.textile", "VERSION.yml", "lib/apis", "lib/apis/generic_api.rb", "lib/apis/google_api.rb", "lib/apis/open_secrets_api.rb", "lib/apis/sunlight_api.rb", "lib/apis/vote_smart_api.rb", "lib/congress_person.rb", "lib/govsdk.rb", "lib/govsdk_base.rb", "lib/govsdkgem.rb", "lib/opmloco.rb", "test/congressperson_test.rb", "test/google_api_test.rb", "test/govsdk_test.rb", "test/open_secrets_api_test.rb", "test/opmloco_test.rb", "test/sunlight_api_test.rb", "test/test_helper.rb", "test/test_template.rb", "test/vote_smart_api_test.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/pitosalas/govsdk}
  s.rdoc_options = ["--inline-source", "--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{TODO}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
