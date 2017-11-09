# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
docs_page = "https://github.com/nyaahara/hook_method"

Gem::Specification.new do |spec|
  spec.name                  = "hook_method"
  spec.version               = "1.0.3"
  spec.summary               = %q{Hook the method call}
  spec.description           = %q{Hook the method call}
  spec.homepage              = docs_page
  spec.authors               = ["nyaahara"]
  spec.license               = "MIT"
  spec.post_install_message  = "#{$-0}\e[5mThank you for installing! (^-^)\e[0m"
  spec.post_install_message += "#{$-0}See also \e[31m\e[47m \e[4m#{docs_page} \e[0m#{$-0}#{$-0}"

  spec.files  = Dir["*.txt"]
  spec.files += Dir["*.md"]
  spec.files += Dir['lib/*.rb']
  spec.require_paths = ["lib"]
end
