//
//  AlertBoxView.swift
//  ChatGPT
//
//  Created by David Aldorf on 09.02.2023.
//

import SwiftUI

struct AlertBoxView: View {
    let viewModel: HomeAlertBoxViewModel = {
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

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let icon = viewModel.config.icon {
                Image(uiImage: icon)
                    .foregroundColor(Color(uiColor: viewModel.config.iconColor ?? .white))
            }

            Text(viewModel.config.title)
                .font(.title)
                .foregroundColor(.white)
            if let subtitle = viewModel.config.subtitle {
                Text(subtitle)
                    .font(.title2)
                    .foregroundColor(.gray)
            }

            if let description = viewModel.config.description {
                Text(description)
                    .font(.body)
                    .foregroundColor(.gray)
                    .lineLimit(nil)
            }

            Button(action: { viewModel.send(.primaryAction) }) {
                Text(viewModel.config.primaryActionTitle)
                    .foregroundColor(.white)
            }
            .background(Color.purple)
            if let secondaryTitle = viewModel.config.secondaryActionTitle {
                Button(action: { viewModel.send(.secondaryAction) }) {
                    Text(secondaryTitle)
                        .foregroundColor(.white)
                }
                .background(Color(.darkGray))
            }
        }
        .padding(.all, 16)
        .background(Color.black)
    }
}

struct AlertBoxView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AlertBoxView()
        }.previewLayout(.fixed(width: 300, height: 300))
    }
}
