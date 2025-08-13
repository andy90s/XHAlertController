# XHAlertController

一个功能强大、高度可自定义的 iOS 弹框控制器，支持多种弹框类型和自定义效果。

## 功能特性

- 🎯 **多种弹框类型**: 支持 Alert 和 ActionSheet 两种基本类型
- 🎨 **高度可自定义**: 支持自定义颜色、圆角、动画等样式
- 📱 **现代化设计**: 遵循 iOS 设计规范，提供流畅的用户体验
- 🔧 **易于扩展**: 模块化设计，便于添加新功能
- ⚡ **性能优化**: 轻量级实现，内存占用小

## 安装

### CocoaPods

```ruby
pod 'XHAlertController'
```

### Swift Package Manager

```swift
dependencies: [
    .package(url: "https://github.com/your-username/XHAlertController.git", from: "1.0.0")
]
```

## 基本用法

### 1. 基础弹框

```swift
import XHAlertController

// 简单提示弹框
let alert = XHAlertController.alert(
    title: "提示",
    message: "这是一个基础弹框",
    buttonTitle: "确定"
) {
    print("用户点击了确定")
}
present(alert, animated: true)
```

### 2. 确认弹框

```swift
let alert = XHAlertController.confirm(
    title: "确认删除",
    message: "确定要删除这个文件吗？",
    confirmTitle: "删除",
    cancelTitle: "取消"
) {
    print("用户确认删除")
} cancelHandler: {
    print("用户取消删除")
}
present(alert, animated: true)
```

### 3. 底部操作表

```swift
let actions = [
    XHAlertAction(title: "拍照", style: .default) {
        print("用户选择拍照")
    },
    XHAlertAction(title: "从相册选择", style: .default) {
        print("用户选择从相册选择")
    },
    XHAlertAction(title: "取消", style: .cancel)
]

let alert = XHAlertController.actionSheet(
    title: "选择图片来源",
    message: "请选择要使用的图片",
    actions: actions
)
present(alert, animated: true)
```

## 高级功能

### 1. 输入框弹框

```swift
let alert = XHAlertController.input(
    title: "输入姓名",
    message: "请输入您的姓名",
    placeholder: "请输入姓名"
) { name in
    print("用户输入的姓名: \(name)")
} cancelHandler: {
    print("用户取消输入")
}
present(alert, animated: true)
```

### 2. 评分弹框

```swift
let alert = XHAlertController.rating(
    title: "评分",
    message: "请为我们的服务评分",
    maxRating: 5,
    currentRating: 0
) { rating in
    print("用户评分: \(rating) 星")
}
present(alert, animated: true)
```

### 3. 选择器弹框

```swift
let options = ["选项1", "选项2", "选项3", "选项4", "选项5"]
let alert = XHAlertController.picker(
    title: "选择选项",
    message: "请从以下选项中选择一个",
    dataSource: options,
    selectedIndex: 0
) { index, value in
    print("用户选择了: \(value) (索引: \(index))")
}
present(alert, animated: true)
```

### 4. 多选弹框

```swift
let options = ["选项A", "选项B", "选项C", "选项D"]
let alert = XHAlertController.multiSelect(
    title: "多选",
    message: "请选择您感兴趣的选项（可多选）",
    options: options,
    selectedOptions: [0, 2]
) { selectedOptions in
    let selectedItems = selectedOptions.map { options[$0] }.joined(separator: ", ")
    print("用户选择了: \(selectedItems)")
}
present(alert, animated: true)
```

### 5. 进度条弹框

```swift
let alert = XHAlertController.progress(
    title: "上传中",
    message: "正在上传文件，请稍候...",
    progress: 0.0
) {
    print("用户取消上传")
}
present(alert, animated: true)

// 更新进度
alert.updateProgress(0.5)
```

### 6. 加载中弹框

```swift
let alert = XHAlertController.loading(title: "正在处理...")
present(alert, animated: true)

// 模拟网络请求
DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
    alert.dismiss(animated: true) {
        print("加载完成")
    }
}
```

## 自定义样式

### 1. 预设样式

```swift
let alert = XHAlertController.alert(title: "操作成功", message: "数据已保存")
alert.setSuccessStyle() // 设置成功样式
present(alert, animated: true)
```

### 2. 自定义样式

```swift
let alert = XHAlertController(title: "自定义样式", message: "这是一个自定义样式的弹框")

// 自定义属性
alert.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.1)
alert.titleColor = .systemBlue
alert.cornerRadius = 20
alert.buttonHeight = 50
alert.contentPadding = UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30)

present(alert, animated: true)
```

### 3. 自定义动画

```swift
let alert = XHAlertController.alert(title: "动画效果", message: "这个弹框使用了特殊动画")
alert.setAnimationType(.bounce) // 设置弹跳动画
present(alert, animated: true)
```

## 自定义内容

### 添加自定义视图

```swift
let alert = XHAlertController(title: "自定义内容", message: "这是一个包含自定义内容的弹框")

// 创建自定义视图
let customView = UIView()
customView.backgroundColor = UIColor.systemGray6
customView.layer.cornerRadius = 8

let imageView = UIImageView()
imageView.image = UIImage(systemName: "star.fill")
imageView.tintColor = .systemYellow
// ... 设置其他视图属性

alert.addCustomView(customView)
alert.addAction(XHAlertAction(title: "确定", style: .default))

present(alert, animated: true)
```

## 按钮样式

支持三种按钮样式：

- `.default`: 默认样式（蓝色背景）
- `.cancel`: 取消样式（灰色背景）
- `.destructive`: 危险样式（红色背景）

```swift
let alert = XHAlertController(title: "按钮样式", message: "展示不同的按钮样式")

alert.addAction(XHAlertAction(title: "确定", style: .default) {
    print("默认按钮")
})

alert.addAction(XHAlertAction(title: "取消", style: .cancel) {
    print("取消按钮")
})

alert.addAction(XHAlertAction(title: "删除", style: .destructive) {
    print("危险按钮")
})

present(alert, animated: true)
```

## 动画类型

支持多种动画类型：

- `.fade`: 淡入淡出（默认）
- `.scale`: 缩放动画
- `.slide`: 滑动动画
- `.bounce`: 弹跳动画

```swift
let alert = XHAlertController.alert(title: "动画", message: "使用特殊动画")
alert.setAnimationType(.bounce)
present(alert, animated: true)
```

## 系统要求

- iOS 12.0+
- Swift 5.0+
- Xcode 12.0+

## 许可证

MIT License

## 贡献

欢迎提交 Issue 和 Pull Request！

## 更新日志

### 1.0.0
- 初始版本发布
- 支持基础弹框和操作表
- 支持自定义样式和动画
- 提供多种便捷工厂方法
- 支持高级功能（评分、选择器、多选、进度条等）


