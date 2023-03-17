//
//  TabBarShape.swift
//  Brawl Stars Insider
//
//  Created by Rajmund Zawiślak on 12/03/2023.
//

import SwiftUI

struct TabBarShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.width
        
        path.move(to: .zero)
        path.addQuadCurve(to: CGPoint(x: width, y: 0), control: CGPoint(x: width/2, y: -48))
        path.addLine(to: .init(x: width, y: rect.maxY))
        path.addLine(to: .init(x: 0, y: rect.maxY))
        path.closeSubpath()
        
        return path
    }
}

struct CurveShape_Previews: PreviewProvider {
    static var previews: some View {
        TabBarShape()
            .fill(Color.blue)
    }
}
