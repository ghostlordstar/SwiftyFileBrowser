# SwiftyFileBrowser
File browser, file manager UI, browser by list, browser by icon,文件浏览器, 列表样式, 图标样式

[![CI Status](https://img.shields.io/travis/Hansen/SwiftyFileBrowser.svg?style=flat)](https://travis-ci.org/Hansen/SwiftyFileBrowser)
[![Version](https://img.shields.io/cocoapods/v/SwiftyFileBrowser.svg?style=flat)](https://cocoapods.org/pods/SwiftyFileBrowser)
[![License](https://img.shields.io/cocoapods/l/SwiftyFileBrowser.svg?style=flat)](https://cocoapods.org/pods/SwiftyFileBrowser)
[![Platform](https://img.shields.io/cocoapods/p/SwiftyFileBrowser.svg?style=flat)](https://cocoapods.org/pods/SwiftyFileBrowser)

## Screen Shot
![Listtype](https://raw.githubusercontent.com/ghostlordstar/SwiftyFileBrowser/main/ScreenShot/st_list.png)
![Listtype](https://raw.githubusercontent.com/ghostlordstar/SwiftyFileBrowser/main/ScreenShot/st_icons.png)
![Listtype](https://raw.githubusercontent.com/ghostlordstar/SwiftyFileBrowser/main/ScreenShot/st_menu.png)
## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements
- iOS 14.0+
- Swift 5.0+

## Feature
- [x] show files with list style
- [x] show files with icon style
- [x] dynamic switch style
- [ ] reload list with difference algorithm  
## Installation

### Cocoapods
SwiftyFileBrowser is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'SwiftyFileBrowser'
```

## Usage
### 1. implement `SFile` protocol

```swift
class FileObject: SFile {

    convenience init(id: String, type: SFileType = .folder, name: String?, detail: String?) {
        self.init()
        self.identifier = id
        self.fileName = name
        self.detailText = detail
        self.fileType = type
    }
    
    var identifier: String = ""
    
    var filePath: String?
    
    var fileName: String?
    
    var detailText: String?
    
    var fileType: SFileType = .unknow
    
    var state: SFileState = .downloading(progress: 0.4)
    
    var thumbnail: UIImage?
    
    var appIcon: UIImage?
}
```
### 2. add `SwiftyFileBrowser` to view
```swift

    let sfbView = SwiftyFileBrowser.init(frame: UIScreen.main.bounds, type: .list)
        sfbView.delegate = self
        let files = [
            FileObject.init(id: "111", type: .folder, name: "name111434534534534523423535436346awefasdfas", detail: "2021/09/11-asdgsfgfadsfadfadfasdfadfadfadfadf"),
            FileObject.init(id: "222", name: "name222", detail: "2021/09/13"),
            FileObject.init(id: "333", name: "name333", detail: "2021/09/14"),
            FileObject.init(id: "444", type: .unknow, name: "name444", detail: "2021/09/14"),
            FileObject.init(id: "555", name: "name555", detail: "2021/09/15"),
            FileObject.init(id: "666", name: "name666", detail: "2021/09/16")
        ]
        sfbView.reloadBrowser(files: files)
        self.view.addSubview(sfbView!)
```

### 3. add UIMenum to longPress gestrue
```swift
        
        let copyEle = UIAction.init(title: "Copy", image: nil, identifier: UIAction.Identifier.init("LongPress-Copy"), discoverabilityTitle: nil, attributes: [], state: .off) { act in
            print("LongPress copy event!,index: \(self.sfbView?.longPressIndex)")
            // TODO: copy logic
        }
        
        let moveEle = UIAction.init(title: "Move", image: nil, identifier: UIAction.Identifier.init("LongPress-Move"), discoverabilityTitle: nil, attributes: [], state: .off) { act in
            print("LongPress Move event!,index: \(self.sfbView?.longPressIndex)")
            // TODO: Move logic
        }
        
        self.sfbView?.longPressMenuElements = [copyEle, moveEle]
```

## Author

Hansen, heshanzhang@outlook.com

## License

SwiftyFileBrowser is available under the MIT license. See the LICENSE file for more info.
