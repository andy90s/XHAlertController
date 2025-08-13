//
//  CommonModalController.swift
//  XHAlertController
//
//  Created by 梁先华 on 2025/8/12.
//

import UIKit

// MARK: - 显示位置枚举
public enum XHModalPresentationPosition: Equatable {
    case center         // 居中显示
    case bottom         // 底部弹出
    case top            // 顶部下拉
    case left           // 左侧滑入
    case right          // 右侧滑入
    case custom(CGPoint) // 自定义位置

    public static func == (lhs: XHModalPresentationPosition, rhs: XHModalPresentationPosition) -> Bool {
        switch (lhs, rhs) {
        case (.center, .center),
             (.bottom, .bottom),
             (.top, .top),
             (.left, .left),
             (.right, .right):
            return true
        case let (.custom(point1), .custom(point2)):
            return point1 == point2
        default:
            return false
        }
    }
}

// MARK: - 动画类型枚举
public enum XHModalAnimationType {
    case none           // 无动画
    case fade           // 淡入淡出
    case scale          // 缩放
    case slide          // 滑动
    case bounce         // 弹跳
    case springScale    // 弹簧缩放
    case flip           // 翻转
}

public class CommonModalController: UIViewController, UIViewControllerTransitioningDelegate {
    public let contentView = UIView()
    public var contentSize: CGSize = .zero
    private var touchView: UIView = .init()

    // 新的显示位置和动画配置
    public var presentationPosition: XHModalPresentationPosition = .center
    public var animationType: XHModalAnimationType = .fade
    public var animationDuration: TimeInterval = 0.3



        // 默认底部弹出的初始化方法
    convenience init(contentSize: CGSize) {
        self.init(contentSize: contentSize, position: .bottom)
    }

    // 新的初始化方法
    convenience init(contentSize: CGSize, position: XHModalPresentationPosition, animationType: XHModalAnimationType = .fade) {
        self.init()
        modalPresentationStyle = .custom
        transitioningDelegate = self
        self.contentSize = contentSize
        self.presentationPosition = position
        self.animationType = animationType

        setupInitialPosition()
        touchView.frame = view.bounds
    }

    // 设置初始位置
    private func setupInitialPosition() {
        switch presentationPosition {
        case .center:
            setupCenterPosition()
        case .bottom:
            setupBottomPosition()
        case .top:
            setupTopPosition()
        case .left:
            setupLeftPosition()
        case .right:
            setupRightPosition()
        case .custom(let point):
            setupCustomPosition(point)
        }
    }

    private func setupCenterPosition() {
        let centerY = (view.bounds.size.height - contentSize.height) / 2
        contentView.frame = CGRect(x: (view.bounds.size.width - contentSize.width) / 2,
                                 y: centerY + 50,  // 初始位置稍微往下
                                 width: contentSize.width,
                                 height: contentSize.height)
        contentView.alpha = 0
    }

    private func setupBottomPosition() {
        contentView.frame = CGRect(x: 0,
                                 y: view.bounds.size.height,
                                 width: view.bounds.size.width,
                                 height: contentSize.height + view.safeAreaInsets.bottom)
    }

    private func setupTopPosition() {
        contentView.frame = CGRect(x: 0,
                                 y: -contentSize.height,
                                 width: view.bounds.size.width,
                                 height: contentSize.height + view.safeAreaInsets.top)
    }

    private func setupLeftPosition() {
        contentView.frame = CGRect(x: -contentSize.width,
                                 y: (view.bounds.size.height - contentSize.height) / 2,
                                 width: contentSize.width,
                                 height: contentSize.height)
    }

    private func setupRightPosition() {
        contentView.frame = CGRect(x: view.bounds.size.width,
                                 y: (view.bounds.size.height - contentSize.height) / 2,
                                 width: contentSize.width,
                                 height: contentSize.height)
    }

    private func setupCustomPosition(_ point: CGPoint) {
        contentView.frame = CGRect(x: point.x - contentSize.width / 2,
                                 y: point.y - contentSize.height / 2,
                                 width: contentSize.width,
                                 height: contentSize.height)
        contentView.alpha = 0
    }

    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        performShowAnimation()
    }

    // 执行显示动画
    private func performShowAnimation() {
        switch animationType {
        case .none:
            // 无动画，直接设置最终位置
            setFinalPosition()
        case .fade:
            performFadeInAnimation()
        case .scale:
            performScaleAnimation()
        case .slide:
            performSlideAnimation()
        case .bounce:
            performBounceAnimation()
        case .springScale:
            performSpringScaleAnimation()
        case .flip:
            performFlipAnimation()
        }
    }

    private func setFinalPosition() {
        switch presentationPosition {
        case .center, .custom:
            let centerY = (view.bounds.size.height - contentSize.height) / 2
            contentView.frame = CGRect(x: (view.bounds.size.width - contentSize.width) / 2,
                                     y: centerY,
                                     width: contentSize.width,
                                     height: contentSize.height)
            contentView.alpha = 1
        case .bottom:
            contentView.frame = CGRect(x: 0,
                                     y: view.bounds.height - contentSize.height - view.safeAreaInsets.bottom,
                                     width: view.bounds.width,
                                     height: contentSize.height + view.safeAreaInsets.bottom)
        case .top:
            contentView.frame = CGRect(x: 0,
                                     y: view.safeAreaInsets.top,
                                     width: view.bounds.width,
                                     height: contentSize.height + view.safeAreaInsets.top)
        case .left:
            contentView.frame = CGRect(x: 0,
                                     y: (view.bounds.size.height - contentSize.height) / 2,
                                     width: contentSize.width,
                                     height: contentSize.height)
        case .right:
            contentView.frame = CGRect(x: view.bounds.size.width - contentSize.width,
                                     y: (view.bounds.size.height - contentSize.height) / 2,
                                     width: contentSize.width,
                                     height: contentSize.height)
        }
    }

    private func performFadeInAnimation() {
        UIView.animate(withDuration: animationDuration) { [weak self] in
            self?.setFinalPosition()
        }
    }

    private func performScaleAnimation() {
        contentView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        UIView.animate(withDuration: animationDuration, delay: 0, options: .curveEaseOut) { [weak self] in
            self?.contentView.transform = .identity
            self?.setFinalPosition()
        }
    }

    private func performSlideAnimation() {
        UIView.animate(withDuration: animationDuration, delay: 0, options: .curveEaseOut) { [weak self] in
            self?.setFinalPosition()
        }
    }

    private func performBounceAnimation() {
        UIView.animate(withDuration: animationDuration, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.8) { [weak self] in
            self?.setFinalPosition()
        }
    }

    private func performSpringScaleAnimation() {
        contentView.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
        UIView.animate(withDuration: animationDuration, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5) { [weak self] in
            self?.contentView.transform = .identity
            self?.setFinalPosition()
        }
    }

    private func performFlipAnimation() {
        contentView.layer.transform = CATransform3DMakeRotation(.pi, 0, 1, 0)
        UIView.animate(withDuration: animationDuration) { [weak self] in
            self?.contentView.layer.transform = CATransform3DIdentity
            self?.setFinalPosition()
        }
    }

    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        performHideAnimation()
    }

    // 执行隐藏动画
    private func performHideAnimation() {
        switch animationType {
        case .none:
            // 无动画
            break
        case .fade:
            performFadeOutAnimation()
        case .scale:
            performScaleOutAnimation()
        case .slide:
            performSlideOutAnimation()
        case .bounce:
            performBounceOutAnimation()
        case .springScale:
            performSpringScaleOutAnimation()
        case .flip:
            performFlipOutAnimation()
        }
    }

    private func performFadeOutAnimation() {
        UIView.animate(withDuration: animationDuration) { [weak self] in
            self?.contentView.alpha = 0
        }
    }

    private func performScaleOutAnimation() {
        UIView.animate(withDuration: animationDuration, delay: 0, options: .curveEaseIn) { [weak self] in
            self?.contentView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            self?.contentView.alpha = 0
        }
    }

    private func performSlideOutAnimation() {
        UIView.animate(withDuration: animationDuration, delay: 0, options: .curveEaseIn) { [weak self] in
            self?.setupInitialPosition()
        }
    }

    private func performBounceOutAnimation() {
        UIView.animate(withDuration: animationDuration, delay: 0, options: .curveEaseIn) { [weak self] in
            self?.setupInitialPosition()
        }
    }

    private func performSpringScaleOutAnimation() {
        UIView.animate(withDuration: animationDuration, delay: 0, options: .curveEaseIn) { [weak self] in
            self?.contentView.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
            self?.contentView.alpha = 0
        }
    }

    private func performFlipOutAnimation() {
        UIView.animate(withDuration: animationDuration) { [weak self] in
            self?.contentView.layer.transform = CATransform3DMakeRotation(.pi, 0, 1, 0)
            self?.contentView.alpha = 0
        }
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        contentView.backgroundColor = .white
        setupCornerRadius()
        view.addSubview(touchView)
        view.addSubview(contentView)
    }

    // 根据显示位置设置圆角
    private func setupCornerRadius() {
        switch presentationPosition {
        case .center, .custom:
            contentView.layer.cornerRadius = 12
            contentView.layer.masksToBounds = true
            contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        case .bottom:
            contentView.layer.cornerRadius = 18
            contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        case .top:
            contentView.layer.cornerRadius = 18
            contentView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        case .left:
            contentView.layer.cornerRadius = 12
            contentView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        case .right:
            contentView.layer.cornerRadius = 12
            contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        }
    }

    @objc func touchDisMissView() {
        dismiss(animated: true) {}
    }

    func disMissView() {
        dismiss(animated: true) {}
    }

    public func animationController(forPresented _: UIViewController, presenting _: UIViewController, source _: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CustomPresentAnimator(duration: 0.15)
    }

    public func animationController(forDismissed _: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CustomPresentAnimator(false, duration: 0.25)
    }

    deinit {
        debugPrint("\(self)\(#function)")
    }
}
