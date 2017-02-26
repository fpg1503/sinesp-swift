# Regex.swift

[![CI Status](http://img.shields.io/travis/fpg1503/Regex.swift.svg?style=flat)](https://travis-ci.org/fpg1503/Regex.swift)
[![Version](https://img.shields.io/cocoapods/v/Regex.swift.svg?style=flat)](http://cocoapods.org/pods/Regex.swift)
[![License](https://img.shields.io/cocoapods/l/Regex.swift.svg?style=flat)](http://cocoapods.org/pods/Regex.swift)
[![Platform](https://img.shields.io/cocoapods/p/Regex.swift.svg?style=flat)](http://cocoapods.org/pods/Regex.swift)

`Regex.swift` is yet another Regex μframework. The main difference is that it's only 68 lines long and intends to keep things simple yet readable. It's been used in production by millions of users and so far has proved itself 100% crash-free.

There are only 2 types: [`Match`](https://github.com/fpg1503/Regex.swift/blob/master/Source/Regex.swift#L28) and [`Regex`](https://github.com/fpg1503/Regex.swift/blob/master/Source/Regex.swift#L40). If I were you I'd read the whole file, it's really quick and will give you a better understanding.

For Swift 2.2 use version 0.1.1.

## Usage

Simply create a `Regex` by using `Regex(pattern:)` or `Regex(pattern: options)`.

To verify if a `String` matches a `Regex` simply use `regex.match(string:)`:
```swift
func validatePlate(plate: String) -> Bool {
    guard let regex = Regex(pattern: "^\\w{3}-?\\d{4}$") else { return false }

    return regex.match(plate)
}
```

If you want to grab the mathes use [`regex.matches(string:)`](https://github.com/fpg1503/Regex.swift/blob/master/Regex.swift/Classes/Regex.swift#L62), it returns an array of [`Match`](https://github.com/fpg1503/Regex.swift/blob/master/Regex.swift/Classes/Regex.swift#L28):

```swift
public init?(plate: String) {
  guard let regex = Regex(pattern: "^(\\w{3})-?(\\d{4})$"),
            captureGroups = regex.matches(plate).first?.captureGroups
            where captureGroups.count == 2 else { return nil }

  letters = captureGroups[0]
  numbers = captureGroups[1]
}
```

## Requirements
- `Regex.swift` relies on `NSRegularExpression` and hopefully won't be necessary anymore when Swift gets a *Swifty* standard Regex API.

- As of version 1.0 `Regex.swift` uses Swift 3.0.


## Installation

[`Regex.swift`](https://github.com/fpg1503/Regex.swift/blob/master/Regex.swift/Classes/Regex.swift) is a single file with 68 lines. You can simply download it and add to your project or use CocoaPods.

Regex.swift is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "Regex.swift"
```

## Contributing
PRs and issues welcome. The only rule here is: keep it as simple as possible.

## FAQ
Why doesn't `Regex` conform to `StringLiteralConvertible`?
- Because I want its initializer to be failable.

## Author

Francesco Perrotti-Garcia, fpg1503@gmail.com

## License

Regex.swift is available under the MIT license. See the LICENSE file for more info.
