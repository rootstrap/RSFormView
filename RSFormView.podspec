
Pod::Spec.new do |s|

  s.name         = "RSFormView"
  s.version      = "2.0.0"
  s.summary      = "A library to easily create customizable form views to collect user data."

  s.description  = "RSFormView allows you to build beutiful forms in a few minutes with out of the box or custom designs."

  s.homepage     = "https://github.com/rootstrap/RSFormView"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"


  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.license      = "MIT"


  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.author             = { "Germán Stábile" => "german.stabile@gmail.com" }
  s.social_media_url   = "https://github.com/germanStabile"

  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.platform     = :ios, "10.0"
  s.swift_version = "5"


  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.source = { :git => "https://github.com/rootstrap/RSFormView.git", :tag => "1.1.1" }


  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.source_files  = "RSFormView/Classes/**/*.{h,m,swift}"
  s.resources = "RSFormView/Classes/**/*.xib"
  s.resource_bundles = {
    'RSFormView' => [
	'RSFormView/Classes/**/*.xib'
	]
  }

  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.dependency "IQKeyboardManagerSwift", "~> 6.1.1"

end
