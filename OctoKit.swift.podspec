Pod::Spec.new do |s|
  s.name             = "OctoKit.swift"
  s.version          = "1.0.0"
  s.summary          = "A Swift API Client for GitHub and GitHub Enterprise"
  s.homepage         = "https://github.com/eonyme/octokit.swift"
  s.license          = 'MIT'
  s.author           = { "eonyme" => "maxwell.me@live.com" }
  s.source           = { :git => "https://github.com/eonyme/octokit.swift.git"}
  s.platform         = :ios, '8.0'
  s.requires_arc     = true
  s.source_files     = 'OctoKit/*.swift'
  s.dependency       "ReactiveSwift"
  s.dependency       "Alamofire"
end