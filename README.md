# SYGalleryPicker
For Sinyi Project library Pre Project

## Demo

## How to Use
```swift
        let vc = SYGalleryPickerViewController()
        vc.modalPresentationStyle = .fullScreen
        sy_presentGalleryPickerController(vc, setting: .TA ,animated: true,
        select: { asset in
            print(asset.description)
        }, deselect: { asset in
            print(asset.description)
        }, cancel: { assets in
            print("Cancel")
        }, finish: { assets in
            print("Confirm")
        }, selectLimitReached: { count in
            print("Limit reach")
        }, completion: nil)
```
Using Clousre instead of delegate, which can be removed if no needed.

The entire function looks like that.
```swift
    func sy_presentGalleryPickerController
        (_ imagePicker: SYGalleryPickerViewController, setting: SinyiProject = .basic, customSetting:SYGalleryPickerSettings? = nil , requestOptions: PHImageRequestOptions? = nil, animated: Bool,
         select: ((_ asset: PHAsset) -> Void)?,
         deselect: ((_ asset: PHAsset) -> Void)?,
         cancel: (([PHAsset]) -> Void)?,
         finish: (([PHAsset]) -> Void)?,
         selectLimitReached: ((Int) -> Void)?,
         completion: (() -> Void)? ) {}
```
針對信義的專案可以選擇Setting，目前主要定義TA與IM這兩個專案可以選擇，若不選擇則會帶入default。
可以自定義setting帶入，再帶入customSetting的情況下前面的setting會變成無效的，目前尚沒有想到比較漂亮的做法。
也可以帶入自己定義的`PHImageRequestOptions`，如果有特殊需求的話。

## Setting
設定的部分要遵守 'SYGalleryPickerSettings' Protocol

```swift
public protocol SYGalleryPickerSettings {

    /// 選取數量
    var maxPickNumber: Int { get set }
    /// 呈現照片欄位
    var countInRow: (_ verticalSize: UIUserInterfaceSizeClass, _ horizontalSize: UIUserInterfaceSizeClass) -> Int { get set }
    /// 標題顏色
    var tintColor: UIColor? { get set }
    /// 標題字的顏色
    var tintTextColor: UIColor? { get set }
    /// 選取顏色
    var pickColor: UIColor { get set }
    /// 是否顯示選取外框
    var pickWithBorder: Bool { get set }
    /// 背景顏色
    var backgroundColor: UIColor { get set }
    /// 選取顯示數字還是打勾
    var selectWithCount: Bool { get set }
    /// 選取的標示所屬的位置
    var selectMarkLocation: selectLocation { get set }
    /// 帶入標題文字取代選取相簿
    var titleText: Bool { get set }
}
```

## Default Selection
將`PHAsset`做成Array就可以選取預設的照片
 ```swift
 let default_selection:[PHAsset] = [...]
 let vc = SYGalleryPickerViewController()
 vc.defaultSelections = default_selection
 ```

## TODO
- [x] ~~選取相簿~~
- [x] ~~選取的計數~~
- [x] ~~預設選取~~
- [x] ~~Controller的Style~~
- [x] ~~不顯示相簿選取~~
- [x] ~~取消選取時其他照片在更新數字時會閃爍~~
- [ ] iCloud image test
- [ ] ~~做成Library~~(不做了)
- [ ] 弄個Pod

## 參考資料
[BSImagePicker](https://github.com/mikaoj/BSImagePicker) 
結構上滿多地方參考這個套件，但是因為有些專案需求所以就只好做一個新的了。