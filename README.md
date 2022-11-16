# TonMnemonicSwift

## Example
To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation
Ready for use on iOS 11+.

### CocoaPods:
[CocoaPods](https://cocoapods.org) is a dependency manager. For usage and installation instructions, visit their website. To integrate using CocoaPods, specify it in your `Podfile`:

```ruby
pod 'TonMnemonicSwift', :git => 'git@github.com:tonkeeper/ton-mnemonic-swift.git', :branch => 'main'
```

### Manually
If you prefer not to use any of dependency managers, you can integrate manually. Put `Source` folder in your Xcode project. Make sure to enable `Copy items if needed` and `Create groups`.

## Quick Start

To generate new mnemonic call this:
```swift
let mnemonic: String =  Mnemonic.mnemonicNew(wordsCount: 24, password: "")
let mnemonicArray: [String] = mnemonic.components(separatedBy: " ")
```

You can validate current mnemonic by call this:
```swift
let isValid: Bool = Mnemonic.mnemonicValidate(mnemonicArray: mnemonicArray, password: "")
```

Extract private key from mnemonic:
```swift
let keyPair = try Mnemonic.mnemonicToPrivateKey(mnemonicArray: mnemonicArray, password: "") 
```

## Author
Sergey Kotov, kotov@tonkeeper.com

## License
ExtensionKit is available under the MIT license. See the LICENSE file for more info.
