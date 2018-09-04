# HaptiHunt

*A simple game to demonstrate the potential for haptic guidance in VR, using [Zorb Touch](https://zorbtouch.com).*

[![license](https://img.shields.io/badge/license-Apache%202.0-green.svg)](https://github.com/SomaticLabs/HaptiHunt/blob/master/LICENSE)
[![Twitter](https://img.shields.io/badge/twitter-@SomaticLabs-orange.svg?style=flat)](http://twitter.com/SomaticLabs)

## About

Made for any Google Cardboard or Google Daydream headset, this demo is a treasure hunt where the user is guided with haptic effects to look for randomly generated cubes in their 3D environment.

This demo is an extension of a [Google Cardboard demo provided by Google](https://github.com/googlevr/gvr-ios-sdk/tree/master/Samples/TreasureHunt
), using their SDK licensed under the Apache License 2.0.

This demo also makes use of [SwitfyZorb](https://github.com/SomaticLabs/SwiftyZorb), which is licensed under the [GNU General Public License v3.0](https://github.com/SomaticLabs/SwiftyZorb/blob/master/LICENSE).

## Requirements

- iOS 10.0+
- Xcode 8.1+
- Swift 4.0+

## Troubleshooting & Contributions

- If you **need help**, [send us an email](mailto:developers@somaticlabs.io).
- If you'd like to **ask a general question**, [send us an email](mailto:developers@somaticlabs.io).
- If you **found a bug**, open an issue.
- If you **have a feature request**, open an issue.
- If you **want to contribute**, submit a pull request.

## Installation

1. Clone this repository:

```sh
$ git clone git@github.com:SomaticLabs/HaptiHunt.git
$ cd HaptiHunt
```

2. Ensure that you have both [CocoaPods](https://guides.cocoapods.org/using/getting-started.html) and [Carthage](https://github.com/Carthage/Carthage) installed:

```sh
$ sudo gem install cocoapods
$ brew update
$ brew install carthage
```

3. Install dependencies:

```sh
pod update
carthage update --platform iOS
```

4. Open workspace (not project) in XCode:

```sh
open HaptiHunt.xcworkspace
```

5. Set your [code signing](https://developer.apple.com/support/code-signing/) preferences.

6. Connect your iOS device, select as build target, and run app (CMD + R).

## Usage

TODO

## Icon Attribution

["Tweemoji"](https://github.com/twitter/twemoji) by Twitter / CC-BY 4.0

## License

This project is licensed under the [Apache License 2.0](https://github.com/SomaticLabs/HaptiHunt/blob/master/LICENSE).
