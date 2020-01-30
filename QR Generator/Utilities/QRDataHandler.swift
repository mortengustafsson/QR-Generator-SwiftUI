//
//  QRDataHandler.swift
//  QRGenerator
//
//  Created by Morten Gustafsson on 6/27/19.
//  Copyright © 2019 mortengustafsson. All rights reserved.
//

import Combine
import SwiftUI

final class QRDataHandler: ObservableObject  {
    @Published var qrImage: UIImage = QRDataHandler.Constants.placeholderImage
    @Published var didCreateQRCode = false

    var userInput = "" {
        didSet {
            guard !userInput.isEmpty else {
                self.didCreateQRCode = false
                self.qrImage = QRDataHandler.Constants.placeholderImage
                return
            }

            if let qrImage = QRGeneratorService.convertTextToQRCode(text: userInput, withSize: Constants.defaultSize) {
                didCreateQRCode = true
                self.qrImage = qrImage
            }
        }
    }

}

extension QRDataHandler {
    enum Constants {
        static let placeholderImage = #imageLiteral(resourceName: "placeholder")
        static let defaultSize = CGSize(width: 1024, height: 1024)
    }
}
