//
//  RoundedCornerShape.swift
//  Brawl Stars Insider
//
//  Created by Rajmund Zawiślak on 03/04/2023.
//

import SwiftUI
import UIKit

struct RoundedCornerShape: Shape {
    
    let radius: CGFloat
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct RoundedCornerShape_Preview: PreviewProvider {
    static var previews: some View {
        Rectangle()
            .frame(width: 30, height: 30)
            .clipShape(
                RoundedCornerShape(
                    radius: 10,
                    corners: [.top, .bottomLeft]
                )
            )
    }
}
