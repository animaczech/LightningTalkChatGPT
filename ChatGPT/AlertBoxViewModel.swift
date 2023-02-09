//
//  AlertBoxViewModel.swift
//  ChatGPTexample
//
//  Created by David Aldorf on 08.02.2023.
//

import Foundation
import UIKit

struct AlertBoxConfig {
    let id: String
    let icon: UIImage? = nil
    var iconColor: UIColor? = nil
    let title: String
    let subtitle: String?
    let description: String?
    let primaryActionTitle: String
    let secondaryActionTitle: String?
}

enum AlertBoxAction {
    case dismiss, primaryAction, secondaryAction
}

protocol ViewModel {
    associatedtype Action
    func send(_ action: Action)
}

protocol AlertBoxViewModel: ViewModel {
    var config: AlertBoxConfig { get set }
}

final class HomeAlertBoxViewModel: AlertBoxViewModel {
    var config: AlertBoxConfig
    private var didSelectDismiss: () -> Void
    private var didSelectPrimaryAction: () -> Void
    private var didSelectSecondaryAction: () -> Void

    init(
        config: AlertBoxConfig,
        didSelectDismiss: @escaping () -> Void,
        didSelectPrimaryAction: @escaping () -> Void,
        didSelectSecondaryAction: @escaping () -> Void
    ) {
        self.config = config
        self.didSelectDismiss = didSelectDismiss
        self.didSelectPrimaryAction = didSelectPrimaryAction
        self.didSelectSecondaryAction = didSelectSecondaryAction
    }

    func send(_ action: AlertBoxAction) {
        switch action {
        case .dismiss:
            didSelectDismiss()
        case .primaryAction:
            didSelectPrimaryAction()
        case .secondaryAction:
            didSelectSecondaryAction()
        }
    }
}


class AlertBoxViewModelMock: AlertBoxViewModel {
    var config: AlertBoxConfig
    private var sendAction: AlertBoxAction?

    init(config: AlertBoxConfig) {
        self.config = config
    }

    func send(_ action: AlertBoxAction) {
        sendAction = action
    }

    var didCallSend: Bool {
        return sendAction != nil
    }

    var lastSentAction: AlertBoxAction? {
        return sendAction
    }
}
