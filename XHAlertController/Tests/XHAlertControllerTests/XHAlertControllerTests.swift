import XCTest
@testable import XHAlertController

final class XHAlertControllerTests: XCTestCase {

    func testAlertControllerCreation() {
        // 测试基础弹框创建
        let alert = XHAlertController.alert(
            title: "测试标题",
            message: "测试消息",
            buttonTitle: "确定"
        )

        XCTAssertEqual(alert.alertTitle, "测试标题")
        XCTAssertEqual(alert.alertMessage, "测试消息")
        XCTAssertEqual(alert.actions.count, 1)
        XCTAssertEqual(alert.actions.first?.title, "确定")
    }

    func testConfirmAlertCreation() {
        // 测试确认弹框创建
        let alert = XHAlertController.confirm(
            title: "确认标题",
            message: "确认消息",
            confirmTitle: "确认",
            cancelTitle: "取消"
        )

        XCTAssertEqual(alert.alertTitle, "确认标题")
        XCTAssertEqual(alert.alertMessage, "确认消息")
        XCTAssertEqual(alert.actions.count, 2)

        // 验证按钮顺序（取消按钮应该在前面）
        XCTAssertEqual(alert.actions[0].title, "取消")
        XCTAssertEqual(alert.actions[0].style, .cancel)
        XCTAssertEqual(alert.actions[1].title, "确认")
        XCTAssertEqual(alert.actions[1].style, .default)
    }

    func testAddAction() {
        // 测试添加操作
        let alert = XHAlertController(title: "测试", message: "消息")
        let action = XHAlertAction(title: "测试按钮", style: .default)

        alert.addAction(action)

        XCTAssertEqual(alert.actions.count, 1)
        XCTAssertEqual(alert.actions.first?.title, "测试按钮")
    }

    func testAlertActionStyles() {
        // 测试不同的按钮样式
        let defaultAction = XHAlertAction(title: "默认", style: .default)
        let cancelAction = XHAlertAction(title: "取消", style: .cancel)
        let destructiveAction = XHAlertAction(title: "删除", style: .destructive)

        XCTAssertEqual(defaultAction.style, .default)
        XCTAssertEqual(cancelAction.style, .cancel)
        XCTAssertEqual(destructiveAction.style, .destructive)
    }

    func testModalPresentationPosition() {
        // 测试模态展示位置
        let centerAlert = XHAlertController(title: "中心", message: "消息", position: .center)
        let bottomAlert = XHAlertController(title: "底部", message: "消息", position: .bottom)

        XCTAssertEqual(centerAlert.presentationPosition, .center)
        XCTAssertEqual(bottomAlert.presentationPosition, .bottom)
    }
}
