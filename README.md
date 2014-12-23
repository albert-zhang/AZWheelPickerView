# AZWheelPickerView

[![CI Status](http://img.shields.io/travis/albert-zhang/AZWheelPickerView.svg?style=flat)](https://travis-ci.org/albert-zhang/AZWheelPickerView)
[![Version](https://img.shields.io/cocoapods/v/AZWheelPickerView.svg?style=flat)](http://cocoadocs.org/docsets/AZWheelPickerView)
[![License](https://img.shields.io/cocoapods/l/AZWheelPickerView.svg?style=flat)](http://cocoadocs.org/docsets/AZWheelPickerView)
[![Platform](https://img.shields.io/cocoapods/p/AZWheelPickerView.svg?style=flat)](http://cocoadocs.org/docsets/AZWheelPickerView)


To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

AZWheelPickerView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

    pod "AZWheelPickerView"

## License

AZWheelPickerView is available under the MIT license. See the LICENSE file for more info.

## Usage

1. `[[AZWheelPickerView alloc] initWithFrame:]`
2. Set `wheelImage`
3. Set `numberOfSectors`
4. Set `wheelInitialRotation` if needed
5. Add target for event `UIControlEventValueChanged` to monitor the `selectedIndex` change
