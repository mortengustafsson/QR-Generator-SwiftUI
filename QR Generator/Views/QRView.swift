//
//  QRView.swift
//  QRGenerator
//
//  Created by Morten Gustafsson on 6/27/19.
//  Copyright © 2019 mortengustafsson. All rights reserved.
//
import Combine
import SwiftUI

struct QRView: View {
    @EnvironmentObject var qrDataHandler: QRDataHandler

    var body: some View {
        Image(uiImage: qrDataHandler.qrImage)
            .resizable()
            .aspectRatio(contentMode: .fit)
        }
}
