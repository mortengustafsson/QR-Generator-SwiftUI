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
    var offset: CGFloat
    @Binding var didFinish: Bool

    var animatableData: AnimatablePair<CGFloat, CGFloat> {
        get { return AnimatablePair<CGFloat, CGFloat>(offset, pct) }
        set {
            offset = newValue.first
            pct = newValue.second
        }
    }

    func effectValue(size: CGSize) -> ProjectionTransform {
        if pct == 1 {
            DispatchQueue.main.async {
               self.didFinish = true
            }
        }

        var rotating = CATransform3DIdentity
        rotating.m34 = -1.0 / 1000

        rotating = CATransform3DRotate(rotating, (CGFloat.pi / 4) * pct, 1, 0, 0)

        let translation = CATransform3DMakeTranslation(0, CGFloat(pct) * offset, 0)

        return ProjectionTransform(CATransform3DConcat(translation, rotating))
    }
}
