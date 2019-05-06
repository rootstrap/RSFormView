
Pod::Spec.new do |s|

  s.name         = "RSFormView"
  s.version      = "0.0.1"
  s.summary      = "A library to easily create form views to collect user data."

  s.description  = <<-DESC
                   DESC

  s.homepage     = "https://github.com/rootstrap/RSFormView"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"


  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.license      = "MIT"


  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.author             = { "Germán Stábile" => "german.stabile@gmail.com" }
  s.social_media_url   = "https://github.com/germanStabile"

  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.platform     = :ios, "10.0"


  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.source       = { :git => "https://github.com/rootstrap/RSFormView" }


  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.source_files  = "RSFormView/RSFormView/**/*"

  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.dependency "IQKeyboardManagerSwift", "~> 6.1.1"

end
