//
//  ChatGPTTests.swift
//  ChatGPTTests
//
//  Created by David Aldorf on 08.02.2023.
//

import XCTest
@testable import ChatGPT

class HomeAlertBoxViewModelTests: XCTestCase {
    var config: AlertBoxConfig!
    var didSelectDismissExpectation: XCTestExpectation!
    var didSelectPrimaryActionExpectation: XCTestExpectation!
    var didSelectSecondaryActionExpectation: XCTestExpectation!
    var viewModel: HomeAlertBoxViewModel!

    override func setUp() {
        super.setUp()
        config = AlertBoxConfig(id: "test_id", title: "test_title", primaryActionTitle: "test_primary_action_title")
        didSelectDismissExpectation = expectation(description: "didSelectDismissExpectation")
        didSelectPrimaryActionExpectation = expectation(description: "didSelectPrimaryActionExpectation")
        didSelectSecondaryActionExpectation = expectation(description: "didSelectSecondaryActionExpectation")
        viewModel = HomeAlertBoxViewModel(config: config, didSelectDismiss: {
            self.didSelectDismissExpectation.fulfill()
        }, didSelectPrimaryAction: {
            self.didSelectPrimaryActionExpectation.fulfill()
        }, didSelectSecondaryAction: {
            self.didSelectSecondaryActionExpectation.fulfill()
        })
    }

    func test_send_dismiss_action() {
        viewModel.send(.dismiss)
        wait(for: [didSelectDismissExpectation], timeout: 1)
    }

    func test_send_primary_action() {
        viewModel.send(.primaryAction)
        wait(for: [didSelectPrimaryActionExpectation], timeout: 1)
    }

    func test_send_secondary_action() {
        viewModel.send(.secondaryAction)
        wait(for: [didSelectSecondaryActionExpectation], timeout: 1)
    }
}

class AlertBoxViewModelMockTests: XCTestCase {
    var config: AlertBoxConfig!
    var viewModel: AlertBoxViewModelMock!

    override func setUp() {
        super.setUp()
        config = AlertBoxConfig(id: "test_id", title: "test_title", primaryActionTitle: "test_primary_action_title")
        viewModel = AlertBoxViewModelMock(config: config)
    }

    func test_send_action() {
        viewModel.send(.dismiss)
        XCTAssertTrue(viewModel.didCallSend)
        XCTAssertEqual(viewModel.lastSentAction, .dismiss)
    }
}

