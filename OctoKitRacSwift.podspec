Pod::Spec.new do |s|
  s.name         = "OctoKitRacSwift"
  s.version      = "1.0.0"
  s.summary      = "A Swift API Client for GitHub and GitHub Enterprise"
  s.description  = <<-EOS
  A Swift API Client for GitHub and GitHub Enterprise.
  EOS
  s.homepage     = "https://github.com/MaxseyLau/OctoKit.RacSwift"
  s.license      = { :type => "MIT", :file => "License.md" }
  s.author             = { "Maxwell" => "maxwell.me@live.com" }
  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.10'
  s.watchos.deployment_target = '2.0'
  s.tvos.deployment_target = '9.0'
  s.source       = { :git => "https://github.com/MaxseyLau/OctoKit.RacSwift.git", :tag => s.version }
  s.default_subspec = "Core"

  s.subspec "Core" do |ss|
    ss.source_files  = "Sources/**"
    ss.dependency "Alamofire", "~> 4.1"
    ss.dependency "Result", "~> 3.0"
    ss.framework  = "Foundation"
  end

  # s.subspec "ReactiveCocoa" do |ss|
  #   ss.dependency "Moya/ReactiveSwift"
  # end

  # s.subspec "ReactiveSwift" do |ss|
  #   ss.source_files = "Sources/ReactiveMoya/"
  #   ss.dependency "Moya/Core"
  #   ss.dependency "ReactiveSwift", "~> 1.1"
  # end

  # s.subspec "RxSwift" do |ss|
  #   ss.source_files = "Sources/RxMoya/"
  #   ss.dependency "Moya/Core"
  #   ss.dependency "RxSwift", "~> 3.0"
  # end
end
