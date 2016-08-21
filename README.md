# sinesp

[![CI Status](http://img.shields.io/travis/fpg1503/sinesp.svg?style=flat)](https://travis-ci.org/fpg1503/sinesp)
[![Version](https://img.shields.io/cocoapods/v/sinesp.svg?style=flat)](http://cocoapods.org/pods/sinesp)
[![License](https://img.shields.io/cocoapods/l/sinesp.svg?style=flat)](http://cocoapods.org/pods/sinesp)
[![Platform](https://img.shields.io/cocoapods/p/sinesp.svg?style=flat)](http://cocoapods.org/pods/sinesp)

## What is it
A SINESP API Client that allows you to get information about brazilian vehicles (using their license plate).

## Installation

sinesp is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "sinesp"
```

## Usage

Create a [`Plate`](https://github.com/fpg1503/sinesp-swift/blob/master/sinesp/Classes/Plate.swift) and get its [`PlateInformation`](https://github.com/fpg1503/sinesp-swift/blob/master/sinesp/Classes/PlateInformation.swift) using `SinespClient().information(for plate:)`:
```swift
if let plate = Plate(plate: "ABC-1234") {
    SinespClient().information(for: plate) { (information) in
        print(information)
    }
}
```

## About SINESP (in portuguese)
O Sinesp Cidadão é um módulo do Sistema Nacional de Informações de Segurança Pública, Prisionais e sobre Drogas, o Sinesp (Lei 12.681/2012), o qual permite acesso direto pelo cidadão aos serviços da Secretaria Nacional de Segurança Pública do Ministério da Justiça.

> "Segurança Pública, dever do Estado, direito e responsabilidade de todos"
> - Art. 144 da Constituição Federal de 1988.

## Full disclaimer
I do not take any responsibility for how you use this API/any of its information.

## Known limitations
- The API does not respond to API addresses outside Brazil.
- The API stops responding when [too many requests are made](https://github.com/victor-torres/sinesp-client/issues/6).
- No support for missing people and arrest warrants.

## Credits
- Based on [victor-torres](https://github.com/victor-torres)'s Python [sinesp-client](https://github.com/victor-torres/sinesp-client)

## Author
Francesco Perrotti-Garcia, fpg1503@gmail.com

## License

sinesp is available under the MIT license. See the LICENSE file for more info.
