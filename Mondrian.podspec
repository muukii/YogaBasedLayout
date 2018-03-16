Pod::Spec.new do |s|
  s.name         = "Mondrian"
  s.version      = "0.1.0"
  s.summary      = "Layout interface"
  s.description  = <<-DESC
  Mondrian provides the layout interface like TetureGroup/Texture with high-optimized layout engine facebook/yoga flexbox implementation.
                   DESC
  s.license      = "MIT"
  s.author             = { "Muukii" => "m@muukii.me" }
  s.social_media_url   = "http://twitter.com/muukii0803"
  s.homepage = "https://muukii.me"

  s.source           = { :git => "https://github.com/muukii/Mondrian.git",
                         :tag => s.version.to_s }

  s.source_files = "Mondrian/**/*.{swift,h,m}"

  s.ios.deployment_target = "8.0"

  s.dependency "YogaKit", ">= 1.8.0"
  # s.dependency 'Yoga', :git => "https://github.com/a2/yoga.git", :tag => 'podspec-1.8.0'
  # s.dependency 'YogaKit', :git => "https://github.com/a2/yoga.git", :tag => 'podspec-1.8.0'


end
