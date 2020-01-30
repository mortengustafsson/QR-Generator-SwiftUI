//
//  KeyboardResponder.swift
//  QR Generator
//
//  Created by Morten Gustafsson on 05/12/2019.
//  Copyright © 2019 mortengustafsson. All rights reserved.
//

import SwiftUI

final class KeyboardResponder: ObservableObject {
    private var notificationCenter: NotificationCenter

    @Published private(set) var isVisible = false

    init(center: NotificationCenter = .default) {
        notificationCenter = center
        notificationCenter.addObserver(self, selector: #selector(keyBoardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyBoardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    deinit {
        notificationCenter.removeObserver(self)
    }

    @objc func keyBoardWillShow(notification: Notification) {
        isVisible = true
    }

    @objc func keyBoardWillHide(notification: Notification) {
        isVisible = false
    }
}
