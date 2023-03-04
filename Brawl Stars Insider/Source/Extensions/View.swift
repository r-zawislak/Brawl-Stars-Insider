//
//  View.swift
//  Brawl Stars Insider
//
//  Created by Rajmund Zawiślak on 03/03/2023.
//

import SwiftUI

extension View {
    func intenseShadow(color: Color, radius: CGFloat, intensity: Int) -> some View {
        var view = AnyView(self)
        let fixedRadius = radius / CGFloat(intensity)
        for _ in 0..<intensity {
            view = AnyView(view.shadow(color: color, radius: fixedRadius))
        }
        
        return view
    }
}

