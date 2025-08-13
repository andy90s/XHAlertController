# XHAlertController

[![Swift](https://img.shields.io/badge/Swift-5.5+-orange.svg)](https://swift.org)
[![iOS](https://img.shields.io/badge/iOS-12.0+-blue.svg)](https://developer.apple.com/ios/)
[![SPM](https://img.shields.io/badge/SPM-compatible-brightgreen.svg)](https://swift.org/package-manager/)
[![CocoaPods](https://img.shields.io/badge/CocoaPods-compatible-red.svg)](https://cocoapods.org/)

一个简洁、优雅的 iOS 弹框库，提供系统级的视觉效果和完美的用户体验。

## ✨ 特性

- 🎯 **简洁的API** - 只需一行代码即可创建弹框
- 🎨 **系统级样式** - 完美匹配 iOS 系统弹框外观
- 🌙 **深色模式支持** - 自动适配 iOS 13+ 深色模式
- 📱 **智能布局** - 按钮数量自动适配水平/垂直布局
- 🔧 **易于集成** - 支持 Swift Package Manager 和 CocoaPods
- ⚡ **轻量级** - 核心功能，无冗余代码

## 📦 安装

### Swift Package Manager

在 Xcode 中：
1. 选择 `File` > `Add Package Dependencies...`
2. 输入仓库地址：`https://github.com/your-username/XHAlertController`
3. 选择版本并添加到项目

或在 `Package.swift` 中添加：

```swift
dependencies: [
    .package(url: "https://github.com/your-username/XHAlertController", from: "1.0.0")
]
```

### CocoaPods

在 `Podfile` 中添加：

```ruby
pod 'XHAlertController'
```

## 🚀 使用方法

### 基础提示弹框

```swift
import XHAlertController

let alert = XHAlertController.alert(
    title: "提示",
    message: "这是一个基础弹框示例",
    buttonTitle: "知道了"
) {
    print("用户点击了知道了")
}
present(alert, animated: true)
```

### 确认对话框

```swift
let alert = XHAlertController.confirm(
    title: "确认删除",
    message: "确定要删除这个文件吗？此操作不可撤销。",
    confirmTitle: "删除",
    cancelTitle: "取消"
) {
    print("用户确认删除")
} cancelHandler: {
    print("用户取消删除")
}
present(alert, animated: true)
```

### 自定义弹框

```swift
let alert = XHAlertController(title: "自定义弹框", message: "可以添加多个按钮")

alert.addAction(XHAlertAction(title: "选项一", style: .default) {
    print("选择了选项一")
})

alert.addAction(XHAlertAction(title: "选项二", style: .default) {
    print("选择了选项二")
})

alert.addAction(XHAlertAction(title: "删除", style: .destructive) {
    print("执行删除操作")
})

alert.addAction(XHAlertAction(title: "取消", style: .cancel))

present(alert, animated: true)
```

## 🎨 样式和布局

### 按钮布局

- **1-2个按钮**：水平排列
- **3个或以上按钮**：垂直排列
- **自动高亮效果**：按钮按下时的高亮效果完美对齐边缘

### 按钮样式

- `.default` - 默认样式（蓝色文字，中等字重）
- `.cancel` - 取消样式（蓝色文字，粗体字重）
- `.destructive` - 危险操作样式（红色文字）

## 📋 系统要求

- iOS 12.0+
- Swift 5.5+
- Xcode 13.0+

## 🤝 贡献

欢迎提交 Issue 和 Pull Request 来改进这个项目！

## 📄 许可证

本项目使用 MIT 许可证。详见 [LICENSE](LICENSE) 文件。

## 👨‍💻 作者

梁先华 - [GitHub](https://github.com/your-username)
