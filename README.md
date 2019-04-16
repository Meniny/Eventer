
<p align="center">
  <!-- <img src="./Assets/Eventer.png" alt="Eventer"> -->
  <br/><a href="https://cocoapods.org/pods/Eventer">
  <img alt="Version" src="https://img.shields.io/badge/version-1.2.0-brightgreen.svg">
  <img alt="Author" src="https://img.shields.io/badge/author-Meniny-blue.svg">
  <img alt="Build Passing" src="https://img.shields.io/badge/build-passing-brightgreen.svg">
  <img alt="Swift" src="https://img.shields.io/badge/swift-5.0%2B-orange.svg">
  <br/>
  <img alt="Platforms" src="https://img.shields.io/badge/platform-iOS-lightgrey.svg">
  <img alt="MIT" src="https://img.shields.io/badge/license-MIT-blue.svg">
  <br/>
  <img alt="Cocoapods" src="https://img.shields.io/badge/cocoapods-compatible-brightgreen.svg">
  <img alt="Carthage" src="https://img.shields.io/badge/carthage-working%20on-red.svg">
  <img alt="SPM" src="https://img.shields.io/badge/swift%20package%20manager-compatible-brightgreen.svg">
  </a>
</p>

## 🏵 Introduction

**Eventer** is a tiny event post/subscribe library for iOS.

## 📋 Requirements

- iOS 8.0+
- Xcode 9.0+ with Swift 5.0+

## 📲 Installation

`Eventer` is available on [CocoaPods](https://cocoapods.org):

```ruby
use_frameworks!
pod 'Eventer'
```

## ❤️ Contribution

You are welcome to fork and submit pull requests.

## 🔖 License

`Eventer` is open-sourced software, licensed under the `MIT` license.

## 💫 Usage

```swift
Eventer.on(self, name: "EventName") { (notification) in
    // ...
}
Eventer.onMainThread(self, name: "AnotherEventName") { (_) in
    // ...
}
```

```swift
Eventer.post(EventName.didAppear.rawValue, on: .main)
```

```swift
Eventer.unregister(self)
```
