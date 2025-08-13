//
//  ViewController.swift
//  Example
//
//  Created by 梁先华 on 2025/8/12.
//

import UIKit
import XHAlertController

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = .systemBackground

        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor, constant: 60),
            stackView.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 20)
        ])

        // 基础弹框
        let basicButton = createButton(title: "基础弹框", action: #selector(showBasicAlert))
        stackView.addArrangedSubview(basicButton)

        // 确认弹框
        let confirmButton = createButton(title: "确认弹框", action: #selector(showConfirmAlert))
        stackView.addArrangedSubview(confirmButton)
    }

    private func createButton(title: String, action: Selector) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: action, for: .touchUpInside)

        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: 200),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])

        return button
    }

    @objc private func showBasicAlert() {
        let alert = XHAlertController.alert(
            title: "提示",
            message: "这是一个基础弹框示例",
            buttonTitle: "知道了"
        ) {
            print("用户点击了知道了")
        }
        present(alert, animated: true)
    }

    @objc private func showConfirmAlert() {
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
    }
}
