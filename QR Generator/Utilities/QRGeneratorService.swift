//
//  QRGeneratorService.swift
//  QRGenerator
//
//  Created by Morten Gustafsson on 6/13/19.
//  Copyright © 2019 mortengustafsson. All rights reserved.
//

import SwiftUI

struct QRGeneratorService {

    // Code inspirerede by: https://stackoverflow.com/questions/22374971/ios-7-core-image-qr-code-generation-too-blur

    static func convertTextToQRCode(text: String, withSize size: CGSize) -> UIImage? {
        let data = text.data(using: String.Encoding.isoLatin1, allowLossyConversion: false)
        guard let filter = CIFilter(name: Constants.CIQRCodeGenerator) else { return nil }
        filter.setValue(data, forKey: Constants.InputMessage)
        filter.setValue(Constants.InputCorrectionLevel.value, forKey: Constants.InputCorrectionLevel.key)

        guard let qrcodeCIImage = filter.outputImage else { return nil }

        guard let cgImage = CIContext(options: nil).createCGImage(qrcodeCIImage, from: qrcodeCIImage.extent) else { return nil }
        UIGraphicsBeginImageContext(CGSize(width: size.width * UIScreen.main.scale, height:size.height * UIScreen.main.scale))
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        context.interpolationQuality = .none
        context.draw(cgImage, in: CGRect(x: 0.0, y: 0.0,width: context.boundingBoxOfClipPath.width,height: context.boundingBoxOfClipPath.height))

        guard let preImage = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()

        guard let ciPreImage = preImage.cgImage else { return nil }

        let qrCodeImage = UIImage(cgImage: ciPreImage, scale: 1.0/UIScreen.main.scale, orientation: .downMirrored)

        return qrCodeImage
    }
}

extension QRGeneratorService {
    enum Constants {
        static let CIQRCodeGenerator = "CIQRCodeGenerator"
        static let InputMessage = "inputMessage"
        
        enum InputCorrectionLevel {
            static let value = "L"
            static let key = "inputCorrectionLevel"
        }
    }
}
