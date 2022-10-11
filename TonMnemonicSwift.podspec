#
# Be sure to run `pod lib lint TonMnemonicSwift.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'TonMnemonicSwift'
  s.version          = '0.0.1'
  s.homepage         = 'https://github.com/tonkeeper/ton-mnemonic-swift'
  s.source           = { :git => 'git@github.com:tonkeeper/ton-mnemonic-swift.git', :tag => s.version.to_s }
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Sergey Kotov' => 'thiskotov@yandex.ru' }
  s.summary          = 'Mnemonic code for generating deterministic keys for TON (The Open Network)'
  

  s.ios.deployment_target = '11.0'
  s.swift_version = '5.0'
  
  s.source_files  = ["Source/*.{swift,h}", "Source/**/*.{swift,c,h}"]
  
end
