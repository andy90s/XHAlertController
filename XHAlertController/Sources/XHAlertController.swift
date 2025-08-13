//
//  XHAlertController.swift
//  XHAlertController
//
//  Created by 梁先华 on 2025/8/12.
//

import Foundation
import UIKit



public enum XHAlertActionStyle {
    case `default`
    case cancel
    case destructive
}

public class XHAlertAction {
    public let title: String
    public let style: XHAlertActionStyle
    public let handler: (() -> Void)?

    public init(title: String, style: XHAlertActionStyle = .default, handler: (() -> Void)? = nil) {
        self.title = title
        self.style = style
        self.handler = handler
    }
}

public class XHAlertController: CommonModalController {

    // MARK: - Properties
    public var alertTitle: String?
    public var alertMessage: String?
    public var actions: [XHAlertAction] = []

    // UI Components
    private let titleLabel = UILabel()
    private let messageLabel = UILabel()
    private let buttonStackView = UIStackView()
    private let contentStackView = UIStackView()


    // Customization options
    public var cornerRadius: CGFloat = 14
    public var backgroundColor: UIColor = {
        if #available(iOS 13.0, *) {
            return .secondarySystemBackground
        } else {
            return .white
        }
    }()
    public var titleColor: UIColor = {
        if #available(iOS 13.0, *) {
            return .label
        } else {
            return .black
        }
    }()
    public var messageColor: UIColor = {
        if #available(iOS 13.0, *) {
            return .secondaryLabel
        } else {
            return .darkGray
        }
    }()
    public var buttonHeight: CGFloat = 44
    public var contentPadding: UIEdgeInsets = UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 16)
    public var maxWidth: CGFloat = 270
    public var maxHeight: CGFloat = 400



    // MARK: - Initialization
    public convenience init(title: String?, message: String?, position: XHModalPresentationPosition = .center, animationType: XHModalAnimationType = .fade) {
        let tempSize = CGSize(width: 280, height: 150) // 临时大小，稍后会重新计算
        self.init(contentSize: tempSize, position: position, animationType: animationType)

        self.alertTitle = title
        self.alertMessage = message

        setupUI()

        // 重新计算并设置内容大小
        let calculatedSize = calculateContentSize()
        self.contentSize = calculatedSize
    }

    // MARK: - Public Methods
    public func addAction(_ action: XHAlertAction) {
        actions.append(action)
        updateButtons()
        updateLayout()

        // 重新计算内容大小
        let calculatedSize = calculateContentSize()
        self.contentSize = calculatedSize
    }



    // MARK: - Private Methods
    private func setupUI() {
        setupAlertLayout()
        configureAlertElements()
        buildAlertLayout()
    }

    private func setupAlertLayout() {
        // Alert 专用的主容器设置
        setupContentStackView()
    }

    private func configureAlertElements() {
        // Alert 专用的元素配置
        configureAlertTitle()
        configureAlertMessage()
        configureAlertButtons()
    }

    private func buildAlertLayout() {
        // Alert 专用的布局构建
        updateLayout()
    }

    private func setupContentStackView() {
        contentStackView.axis = .vertical
        contentStackView.spacing = 0
        contentStackView.alignment = .fill
        contentStackView.distribution = .fill

        contentView.addSubview(contentStackView)
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: contentPadding.top),
            contentStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: contentPadding.left),
            contentStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -contentPadding.right),
            contentStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    private func configureAlertTitle() {
        // Alert 专用的标题配置（与 ActionSheet 不同）
        titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        if #available(iOS 13.0, *) {
            titleLabel.textColor = .label
        } else {
            titleLabel.textColor = .black
        }
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.text = alertTitle
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
    }

    private func configureAlertMessage() {
        // Alert 专用的消息配置（与 ActionSheet 不同）
        messageLabel.font = UIFont.systemFont(ofSize: 13)
        if #available(iOS 13.0, *) {
            messageLabel.textColor = .secondaryLabel
        } else {
            messageLabel.textColor = .darkGray
        }
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0
        messageLabel.text = alertMessage
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
    }

    private func configureAlertButtons() {
        // Alert 专用的按钮配置（支持水平和垂直布局）
        buttonStackView.axis = .horizontal  // 默认水平，会根据按钮数量动态调整
        buttonStackView.spacing = 0
        buttonStackView.alignment = .fill
        buttonStackView.distribution = .fillEqually
    }

    // 保持向后兼容
    private func setupTitleLabel() {
        configureAlertTitle()
    }

    private func setupMessageLabel() {
        configureAlertMessage()
    }

    private func setupButtonStackView() {
        configureAlertButtons()
    }



    private func updateLayout() {
        contentStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

        if let title = alertTitle, !title.isEmpty {
            contentStackView.addArrangedSubview(titleLabel)
            // 添加标题下方间距
            contentStackView.setCustomSpacing(8, after: titleLabel)
        }

        if let message = alertMessage, !message.isEmpty {
            contentStackView.addArrangedSubview(messageLabel)
            // 添加消息下方间距
            contentStackView.setCustomSpacing(20, after: messageLabel)
        }



        if !actions.isEmpty {
            // 添加分割线容器，让分割线延伸到完整宽度
            let separatorContainer = createSeparatorContainer()
            contentStackView.addArrangedSubview(separatorContainer)

            // 创建按钮容器，移除左右边距
            let buttonContainer = createButtonContainer()
            contentStackView.addArrangedSubview(buttonContainer)
        }
    }

    private func createButtonContainer() -> UIView {
        let container = UIView()
        container.addSubview(buttonStackView)

        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonStackView.topAnchor.constraint(equalTo: container.topAnchor),
            buttonStackView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: -contentPadding.left),
            buttonStackView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: contentPadding.right),
            buttonStackView.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        ])

        return container
    }

    private func createSeparatorContainer() -> UIView {
        let container = UIView()
        let separator = UIView()

        if #available(iOS 13.0, *) {
            separator.backgroundColor = .separator
        } else {
            separator.backgroundColor = UIColor(white: 0.8, alpha: 1.0)
        }

        container.addSubview(separator)
        separator.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            separator.topAnchor.constraint(equalTo: container.topAnchor),
            separator.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: -contentPadding.left),
            separator.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: contentPadding.right),
            separator.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            separator.heightAnchor.constraint(equalToConstant: 0.5)
        ])

        return container
    }

    private func createSeparatorView() -> UIView {
        let separator = UIView()
        if #available(iOS 13.0, *) {
            separator.backgroundColor = .separator
        } else {
            separator.backgroundColor = UIColor(white: 0.8, alpha: 1.0)
        }
        separator.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        return separator
    }

            private func updateButtons() {
        buttonStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

        // Alert 弹框逻辑：2个或以下按钮使用水平布局，3个或以上使用垂直布局
        if actions.count <= 2 {
            // 水平布局
            buttonStackView.axis = .horizontal
            buttonStackView.distribution = .fill
            buttonStackView.spacing = 0

            var buttons: [UIButton] = []

            for (index, action) in actions.enumerated() {
                let button = createButton(for: action)
                buttons.append(button)
                buttonStackView.addArrangedSubview(button)

                // 添加垂直分割线（除了最后一个按钮）
                if index < actions.count - 1 {
                    let verticalSeparator = createVerticalSeparatorView()
                    buttonStackView.addArrangedSubview(verticalSeparator)
                }
            }

            // 确保按钮等宽
            if buttons.count > 1 {
                for i in 1..<buttons.count {
                    buttons[i].widthAnchor.constraint(equalTo: buttons[0].widthAnchor).isActive = true
                }
            }
        } else {
            // 垂直布局
            buttonStackView.axis = .vertical
            buttonStackView.distribution = .fillEqually
            buttonStackView.spacing = 0

            for (index, action) in actions.enumerated() {
                let button = createButton(for: action)
                buttonStackView.addArrangedSubview(button)

                // 添加水平分割线（除了最后一个按钮）
                if index < actions.count - 1 {
                    let horizontalSeparator = createHorizontalSeparatorView()
                    buttonStackView.addArrangedSubview(horizontalSeparator)
                }
            }
        }
    }

    private func createVerticalSeparatorView() -> UIView {
        let separator = UIView()
        if #available(iOS 13.0, *) {
            separator.backgroundColor = .separator
        } else {
            separator.backgroundColor = UIColor(white: 0.8, alpha: 1.0)
        }
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.widthAnchor.constraint(equalToConstant: 0.5).isActive = true
        return separator
    }

    private func createHorizontalSeparatorView() -> UIView {
        let separator = UIView()
        if #available(iOS 13.0, *) {
            separator.backgroundColor = .separator
        } else {
            separator.backgroundColor = UIColor(white: 0.8, alpha: 1.0)
        }
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        return separator
    }

    private func createButton(for action: XHAlertAction) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(action.title, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 0
        button.translatesAutoresizingMaskIntoConstraints = false

        // 设置按钮高度约束
        let heightConstraint = button.heightAnchor.constraint(equalToConstant: buttonHeight)
        heightConstraint.priority = UILayoutPriority(999) // 高优先级但不是必需的
        heightConstraint.isActive = true

        // 设置按钮文字颜色
        switch action.style {
        case .default:
            button.setTitleColor(.systemBlue, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        case .cancel:
            button.setTitleColor(.systemBlue, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        case .destructive:
            button.setTitleColor(.systemRed, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        }

        // 添加高亮效果
        button.addTarget(self, action: #selector(buttonHighlighted(_:)), for: .touchDown)
        button.addTarget(self, action: #selector(buttonUnhighlighted(_:)), for: [.touchUpInside, .touchUpOutside, .touchCancel])

        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        // 找到action的索引
        if let index = actions.firstIndex(where: { $0 === action }) {
            button.tag = index
        } else {
            button.tag = 0
        }

        return button
    }

    @objc private func buttonTapped(_ sender: UIButton) {
        let index = sender.tag
        guard index < actions.count else { return }

        let action = actions[index]
        dismiss(animated: true) {
            action.handler?()
        }
    }

    @objc private func buttonHighlighted(_ sender: UIButton) {
        if #available(iOS 13.0, *) {
            sender.backgroundColor = .systemGray5
        } else {
            sender.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        }
    }

    @objc private func buttonUnhighlighted(_ sender: UIButton) {
        sender.backgroundColor = .clear
    }

        private func calculateContentSize() -> CGSize {
        let width = min(maxWidth, UIScreen.main.bounds.width - 40)
        let contentWidth = width - contentPadding.left - contentPadding.right

        // 基础内容高度
        var height: CGFloat = contentPadding.top

        if let title = alertTitle, !title.isEmpty {
            let titleSize = title.boundingRect(
                with: CGSize(width: contentWidth, height: CGFloat.greatestFiniteMagnitude),
                options: [.usesLineFragmentOrigin, .usesFontLeading],
                attributes: [.font: UIFont.systemFont(ofSize: 17, weight: .semibold)],
                context: nil
            ).size
            height += ceil(titleSize.height)
            height += 8  // 标题下边距
        }

        if let message = alertMessage, !message.isEmpty {
            let messageSize = message.boundingRect(
                with: CGSize(width: contentWidth, height: CGFloat.greatestFiniteMagnitude),
                options: [.usesLineFragmentOrigin, .usesFontLeading],
                attributes: [.font: UIFont.systemFont(ofSize: 13)],
                context: nil
            ).size
            height += ceil(messageSize.height)
            height += 20 // 消息下边距
        }

        if !actions.isEmpty {
            height += 0.5 // 分割线高度

            if actions.count <= 2 {
                // 水平布局，只有一行按钮
                height += buttonHeight
            } else {
                // 垂直布局，多行按钮
                height += buttonHeight * CGFloat(actions.count) // 按钮总高度
                height += 0.5 * CGFloat(actions.count - 1) // 分割线总高度
            }
        }

        // 限制最大高度
        height = min(height, maxHeight)

        return CGSize(width: width, height: height)
    }

    // MARK: - Override
    public override func viewDidLoad() {
        super.viewDidLoad()
        contentView.backgroundColor = backgroundColor
        contentView.layer.cornerRadius = cornerRadius
    }




}

// MARK: - Convenience Initializers
public extension XHAlertController {

    /// 创建简单的确认弹框
    static func confirm(title: String?, message: String?, confirmTitle: String = "确定", cancelTitle: String = "取消", confirmHandler: (() -> Void)? = nil, cancelHandler: (() -> Void)? = nil) -> XHAlertController {
        let alert = XHAlertController(title: title, message: message)

        alert.addAction(XHAlertAction(title: cancelTitle, style: .cancel, handler: cancelHandler))
        alert.addAction(XHAlertAction(title: confirmTitle, style: .default, handler: confirmHandler))

        return alert
    }

    /// 创建简单的提示弹框
    static func alert(title: String?, message: String?, buttonTitle: String = "确定", handler: (() -> Void)? = nil) -> XHAlertController {
        let alert = XHAlertController(title: title, message: message)
        alert.addAction(XHAlertAction(title: buttonTitle, style: .default, handler: handler))
        return alert
    }




}


