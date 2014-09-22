# AZWheelPickerView


A spin wheel control for selecting something.

![Screenshot](http://landinggearup.com/download/image/AZWheelPickerView.jpg)

## Usage

1. `[[AZWheelPickerView alloc] initWithFrame:]`
2. Set `wheelImage`
3. Set `numberOfSectors`
4. Set `wheelInitialRotation` if needed
5. Add target for event `UIControlEventValueChanged` to monitor the `selectedIndex` change

