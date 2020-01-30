//
//  UIApplication+endEditing.swift
//  QR Generator
//
//  Created by Morten Gustafsson on 06/12/2019.
//  Copyright © 2019 mortengustafsson. All rights reserved.
//

import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
