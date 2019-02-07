Pod::Spec.new do |s|
  s.name                   = "BadgeControl"
  s.version                = "1.1"
  s.summary                = "Simple framework for adding a badge to UIView."
  s.description            = "Simply attach BadgeController to any UIView's subclasses and easily control the badge. Customize size, position, background color, text color and animation of the badge."
  s.homepage               = "https://github.com/kiwisip/BadgeControl.git"
  s.license                = "MIT"
  s.author                 = { "Robin Krenecky" => "rkrenecky@gmail.com" }
  s.platform               = :ios, "9.0"
  s.source                 = { :git => "https://github.com/kiwisip/BadgeControl.git", :tag => s.version }
  s.source_files           = "BadgeControl", "BadgeControl/**/*.{h,m,swift}"
  s.exclude_files          = "Classes/Exclude"
  s.pod_target_xcconfig    = { 'SWIFT_VERSION' => '4.2' }
  s.ios.deployment_target  = "9.0"
  s.tvos.deployment_target = "9.0"
  s.frameworks = "UIKit"
end
