//
//  AlertBoxViewController.swift
//  ChatGPTexample
//
//  Created by David Aldorf on 08.02.2023.
//

import Foundation
import UIKit

final class AlertBoxViewController: UIViewController {
    lazy var viewModel: HomeAlertBoxViewModel = {
        let config = AlertBoxConfig(
            id: "1",
            title: "Test Title",
            subtitle: "Test Subtitle",
            description: "Test Description",
            primaryActionTitle: "Primary Action",
            secondaryActionTitle: "Secondary Action"
        )

        return HomeAlertBoxViewModel(config: config, didSelectDismiss: {}, didSelectPrimaryAction: {}, didSelectSecondaryAction: {})
    }()

    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()

    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        return label
    }()

    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }()

    let primaryButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .purple
        button.tintColor = .white
        return button
    }()

    let secondaryButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .darkGray
        button.tintColor = .white
        return button
    }()

    let containerView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 8

        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstraints()
    }

    private func setupViews() {
        // Configure iconImageView
        iconImageView.image = viewModel.config.icon
        iconImageView.tintColor = viewModel.config.iconColor

        // Configure titleLabel
        titleLabel.text = viewModel.config.title

        // Configure subtitleLabel
        subtitleLabel.text = viewModel.config.subtitle

        // Configure descriptionLabel
        descriptionLabel.text = viewModel.config.description

        // Configure primaryActionButton
        primaryButton.setTitle(viewModel.config.primaryActionTitle, for: .normal)
        primaryButton.addTarget(self, action: #selector(didTapPrimaryAction), for: .touchUpInside)

        // Configure secondaryActionButton
        secondaryButton.setTitle(viewModel.config.secondaryActionTitle, for: .normal)
        secondaryButton.addTarget(self, action: #selector(didTapSecondaryAction), for: .touchUpInside)

        // Add subviews
        view.addSubview(containerView)
        containerView.addArrangedSubview(iconImageView)
        containerView.addArrangedSubview(titleLabel)
        containerView.addArrangedSubview(subtitleLabel)
        containerView.addArrangedSubview(descriptionLabel)
        containerView.addArrangedSubview(primaryButton)
        containerView.addArrangedSubview(secondaryButton)

        // Set constraints
        setConstraints()

        // Style the view
        view.backgroundColor = .black
    }

    func setConstraints() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }


    @objc private func didTapDismiss() {
        viewModel.send(.dismiss)
    }

    @objc private func didTapPrimaryAction() {
        viewModel.send(.primaryAction)
    }

    @objc private func didTapSecondaryAction() {
        viewModel.send(.secondaryAction)
    }
}
