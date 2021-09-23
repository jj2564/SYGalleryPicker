# SYGalleryPicker

<p align="left">
<a><img src="https://img.shields.io/badge/language-swift-orange.svg"></a>
<a href="https://cocoapods.org/pods/SYGalleryPicker"><img src="https://img.shields.io/cocoapods/p/SYGalleryPicker.svg?style=flat"></a>
<a href="https://travis-ci.org/jj2564/SYGalleryPicker"><img src="https://app.travis-ci.com/jj2564/SYGalleryPicker.svg?branch=master"></a>
<a href="https://cocoapods.org/pods/SYGalleryPicker"><img src="https://img.shields.io/cocoapods/v/SYGalleryPicker.svg?style=flat"></a>
<a href="https://cocoapods.org/pods/SYGalleryPicker"><img src="https://img.shields.io/cocoapods/l/SYGalleryPicker.svg?style=flat"></a>
</p>

A photo select library.

## News
- Now support iOS14 permission. 

## Requirements
`iOS 10`

## Installation
SYGalleryPicker is available through [CocoaPods](https://cocoapods.org/). 
Add the following line to your Podfile:

```ruby
pod "SYGalleryPicker"
```

Enter in the terminal

```ruby
$ pod install --repo-update
```

## Demo
<img src="https://raw.githubusercontent.com/jj2564/SYGalleryPicker/master/screenshots/basic_style.png" width="320"> <img src="https://raw.githubusercontent.com/jj2564/SYGalleryPicker/master/screenshots/album_switch.png" width="320">

## How to Use
```swift
let vc = SYGalleryPickerViewController()
vc.modalPresentationStyle = .fullScreen
vc.syPresentGalleryPickerController(self, animated: true,
select: { asset in
    print(asset.description)
}, deselect: { asset in
    print(asset.description)
}, cancel: { assets in
    print("Cancel")
}, finish: { assets in
    print("Confirm")
}, photoSelectLimitReached: { count in
    print("Limit reach")
}, authorizedDenied: nil, authorizedLimited: {
        print("is now limited")
}, completion: nil )
```
Using Clousre instead of delegate, which can be set to *nil* if no needed.

The entire function looks like this:
```swift
func syPresentGalleryPickerController
(_ viewController: UIViewController, style: SelectStyle = .basic, customSetting:SYGalleryPickerSettings? = nil , requestOptions: PHImageRequestOptions? = nil, animated: Bool,
select: ((_ asset: PHAsset) -> Void)?,
deselect: ((_ asset: PHAsset) -> Void)?,
cancel: (([PHAsset]) -> Void)?,
finish: (([PHAsset]) -> Void)?,
photoSelectLimitReached: ((Int) -> Void)?,
authorizedDenied:(() -> Void)?,
authorizedLimited:(() -> Void)? = nil,
completion: (() -> Void)? ) {}
```
If you use the paremeter of **customSetting**, the **style** will be no effort. All settings will follow the customize settings.

You may also set the `PHImageRequestOptions` to **requestOptions** when you called **syPresentGalleryPickerController**. If not, it will be set like this:
```swift
imageRequestOptions = PHImageRequestOptions()
imageRequestOptions?.deliveryMode = .highQualityFormat
imageRequestOptions?.resizeMode = .exact
imageRequestOptions?.isNetworkAccessAllowed = false
```


## Setting
Setting must follow the protocol `SYGalleryPickerSettings`.

```swift
public protocol SYGalleryPickerSettings {

    // MARK: Enviorment
    /// status bar style
    var statusBarStyle: UIStatusBarStyle { get }
    /// select limit count in picker
    var pickLimitCount: Int { get }
    /// count per row in picker
    var countInRow: (_ verticalSize: UIUserInterfaceSizeClass, _ horizontalSize: UIUserInterfaceSizeClass) -> Int { get }
    /// use a title text instead of album select
    var titleText: Bool { get }
    /// text with confirm button
    var confirmButtonText: String { get }
    
    // MARK: Picker Style
    /// color of navigation bar
    var tintColor: UIColor? { get }
    /// color of navigation title
    var tintTextColor: UIColor? { get }
    /// background color of picker
    var backgroundColor: UIColor { get }
    
    // MARK: Selected style
    /// select mark and select border color
    var pickedColor: UIColor { get }
    /// select mark location of the cell
    var pickedMarkLocation: selectLocation { get }
    /// use count on select view
    var isPickedWithCount: Bool { get }
    /// show select border ot not
    var isPickWithBorder: Bool { get }

}
```
If you want to customize your style. Create a new class and inherit `SYGalleryPickerSettings`.
You set the value like this:

```swift
final class IMSetting: SYGalleryPickerSettings {

    var pickLimitCount: Int = 10
    var cancelButtonText: String = "取消"
    var confirmButtonText: String = "確認"
    var pickedColor: UIColor = .green_008800
    var isPickedWithCount: Bool = false
    var isPickWithBorder: Bool = false
}
```

You do not need to install all settings.

## Default Selection
Make `PHAsset` as an `Array` and set it to **defaultSelections**.

 ```swift
 let default_selection:[PHAsset] = [...]
 let vc = SYGalleryPickerViewController()
 vc.defaultSelections = default_selection
 ```
 
Notice that. If the **defaultSelections** count more than the limit select it will still be selected.

## TODO
- [ ] clean the garbage code due to the latest requirement
- [ ] find the solution of strange problem
- [ ] split datasource from cell
- [x] refresh after user delete the photo
- [ ] iCloud image test
- [ ] unit test

## Reference
[BSImagePicker](https://github.com/mikaoj/BSImagePicker)   
This Lib is powerfull, but I have some special requirement. 

## Author
jj2564, jamek8@gmail.com

## License
SYGalleryPicker is available under the MIT license. See the LICENSE file for more info.
