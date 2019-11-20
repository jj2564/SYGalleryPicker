# SYGalleryPicker
For Sinyi Project library Pre Project

## 使用方式
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
不使用delegate通通使用clourse來回傳，用不到的可以直接拿掉。


以下為呼叫函式的樣貌
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
    var tintColor: UIColor { get set }
    /// 選取顏色
    var pickColor: UIColor { get set }
    /// 背景顏色
    var backgroundColor: UIColor { get set }
    /// 選取顯示數字還是打勾
    var selectWithCount: Bool { get set }
    /// 選取的標示所屬的位置
    var selectMarkLocation: selectLocation { get set }

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
- [ ] 關閉相簿選取
- [ ] 做成Library
- [ ] 弄個Pod

## 參考資料
[BSImagePicker](https://github.com/mikaoj/BSImagePicker)