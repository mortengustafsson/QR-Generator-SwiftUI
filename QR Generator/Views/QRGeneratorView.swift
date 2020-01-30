//
//  QRGeneratorView.swift
//  QRGenerator
//
//  Created by Morten Gustafsson on 6/27/19.
//  Copyright © 2019 mortengustafsson. All rights reserved.
//

import SwiftUI
import Combine

struct QRGeneratorView: View {

    @EnvironmentObject private var qrDataHandler: QRDataHandler
    @ObservedObject private var keyboard = KeyboardResponder()

    @State private var animationDidFinish = false
    @State private var animate = false
    @State private var shouldAnimate: Bool = false

    private let animation = Animation.easeInOut(duration: 1.0)

    var body: some View {

        let flyoutEffectBinding = Binding<Bool>( get: { self.animationDidFinish }, set: { self.updateBinding($0) })
        let flyOutEffect = FlyOutEffect(pct: animate ? 1 : 0, offset: CGFloat(UIScreen.main.bounds.height), didFinish: flyoutEffectBinding)
        
        return VStack {
            Spacer()

            Text(Constants.Headline.text)
                .font(.system(size: Constants.Headline.fontSize, weight: Font.Weight.black, design: Font.Design.default))
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                .padding(Constants.defaultPadding)

            InputView()
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                .padding(Constants.defaultPadding)

            ZStack{
                if (!shouldAnimate) {
                    QRView()
                        .padding(Constants.QrPreview.padding)
                }

                if shouldAnimate {
                    QRView()
                        .modifier(flyOutEffect)
                        .padding(Constants.QrPreview.padding)
                        .animation(animation)

                    QRView()
                        .padding(Constants.QrPreview.padding)
                        .scaleEffect(animate ? 1 : 0.8)
                        .animation(animation)
                        .zIndex(-1)
                }
            }

            Button(
                action: {
                    self.saveQRCode()
            }, label: {
                Text(Constants.Button.text)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding(Constants.Button.labelPadding)
                    .foregroundColor(Constants.Button.textColor)
            })
                .background(Constants.Button.backgroundColor)
                .cornerRadius(Constants.Button.cornerRadius)
                .disabled(!qrDataHandler.didCreateQRCode)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                .padding(Constants.defaultPadding)
                .zIndex(-1)

            Spacer()

            Button(
                action: {
                    self.openUrl(Constants.ReadMoreButton.url)
            }, label: {
                Text(Constants.ReadMoreButton.text)
                    .font(.system(size: Constants.ReadMoreButton.fontSize, weight: Font.Weight.light, design: Font.Design.default))
                    .foregroundColor(Constants.ReadMoreButton.textColor)
                    .underline()
            })
                .zIndex(-1)
        }.onTapGesture {
            self.endEditing()
        }
    }

    private func updateBinding(_ value: Bool) {
        animationDidFinish = value
        self.shouldAnimate = false
        self.animate = false
    }

    private func endEditing() {
        UIApplication.shared.endEditing()
    }

    private func saveQRCode() {
        let albumManager = AlbumManager()
        albumManager.save(image: qrDataHandler.qrImage, completion: { didSave in
            if didSave {
                self.shouldAnimate = true
                withAnimation() {
                    self.animate = true
                }
            }
        })
    }

    private func openUrl(_ url: String) {
        guard let url = URL(string: url),
            UIApplication.shared.canOpenURL(url) else {
                return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}

extension QRGeneratorView {
    enum Constants {
        static let defaultPadding = EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 30)

        enum Headline {
            static let text = "QR\nGenerator"
            static let fontSize: CGFloat = 50
        }

        enum Button {
            static let padding = EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 30)
            static let labelPadding = EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
            static let cornerRadius: CGFloat = 40
            static let textColor = Color.white
            static let backgroundColor = Color.red
            static let text = "Save QR Code"
        }

        enum QrPreview {
            static let padding = EdgeInsets(top: 20, leading: 30, bottom: 30, trailing: 30)
        }

        enum ReadMoreButton {
            static let textColor = Color.black
            static let fontSize: CGFloat = 12
            static let url = "https://github.com/mortengustafsson"
            static let text = "Morten Gustafsson"
        }
    }
}

#if DEBUG
struct QRGeneratorView_Preview: PreviewProvider {
    static var previews: some View {
        QRGeneratorView()
    }
}
#endif
