//
//  FlyOutEffect.swift
//  QR Generator
//
//  Created by Morten Gustafsson on 29/01/2020.
//  Copyright © 2020 mortengustafsson. All rights reserved.
//

import SwiftUI

struct FlyOutEffect: GeometryEffect {

    var pct: CGFloat

    @Binding var didFinish: Bool

    var animatableData: CGFloat {
        get { return pct }
        set { pct = newValue }
    }


    func effectValue(size: CGSize) -> ProjectionTransform {
        if pct == 1 {
            DispatchQueue.main.async {
               self.didFinish = true
            }
        }

        var rotating = CATransform3DIdentity
        rotating.m34 = -1/850

        rotating = CATransform3DRotate(rotating, (CGFloat.pi / 4) * pct, 1, 0, 0)

        let translation = CATransform3DMakeTranslation(0, CGFloat(pct) * CGFloat(UIScreen.main.bounds.height), 0)

        return ProjectionTransform(CATransform3DConcat(translation, rotating))
    }
}
