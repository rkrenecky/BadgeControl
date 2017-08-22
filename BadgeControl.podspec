Pod::Spec.new do |s|


  s.name         = "BadgeControl"
  s.version      = "1.0.4"
  s.summary      = "Simple framework for adding a badge to UIView."

  # This description is used to generate tags and improve search results.
  #   * Think: What does it do? Why did you write it? What is the focus?
  #   * Try to keep it short, snappy and to the point.
  #   * Write the description between the DESC delimiters below.
  #   * Finally, don't worry about the indent, CocoaPods strips it!
  s.description  = "Simply attach BadgeController to any UIView's subclasses and easily control the badge. Customize size, position, background color, text color and animation of the badge."

  s.homepage     = "https://github.com/kiwisip/BadgeControl.git"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"

  s.license      = "MIT"

  s.author             = { "Robin Krenecky" => "rkrenecky@gmail.com" }

  s.platform     = :ios, "9.0"

  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the location from where the source should be retrieved.
  #  Supports git, hg, bzr, svn and HTTP.
  #

  s.source       = { :git => "https://github.com/kiwisip/BadgeControl.git", :tag => "1.0.4" }

  s.source_files  = "BadgeControl", "BadgeControl/**/*.{h,m,swift}"
  s.exclude_files = "Classes/Exclude"
  
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '4' }

end
