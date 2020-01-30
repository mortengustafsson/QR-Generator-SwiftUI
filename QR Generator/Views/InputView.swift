//
//  InputView.swift
//  QR Generator
//
//  Created by Morten Gustafsson on 06/12/2019.
//  Copyright © 2019 mortengustafsson. All rights reserved.
//

import SwiftUI
import Combine

struct InputView: View {
    @EnvironmentObject private var qrDataHandler: QRDataHandler

    var body: some View {
        VStack {
            TextField(Constants.TextField.placeholderText, text: $qrDataHandler.userInput)
                .autocapitalization(.none)
                .accentColor(Constants.TextField.accentColor)

            Rectangle()
                .frame(height: Constants.Rectangle.height, alignment: .bottom)
                .foregroundColor(Constants.Rectangle.color)
        }
    }
}

extension InputView {
    enum Constants {
        enum TextField {
            static let placeholderText = "Add a message."
            static let accentColor = Color.red
        }
        enum Rectangle {
            static let height: CGFloat = 2.0
            static let color = Color.red
        }
    }
}




