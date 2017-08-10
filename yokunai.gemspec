Gem::Specification.new do |s|
  s.name = "yokunai"
  s.version = "0.1.0"
  s.summary = "Helps you make really simple dynamic Internet Web Pages."
  s.description =
  s.authors = ["Alex Blackie"]
  s.email = "alex@alexblackie.com"
  s.files = Dir["README.markdown", "lib/**/*"]
  s.homepage = "https://github.com/alexblackie/yokunai"
  s.license = "BSD-3-Clause"

  s.add_runtime_dependency "rack", "~> 2.0"
  s.add_runtime_dependency "mimemagic", "~> 0.3"
end
