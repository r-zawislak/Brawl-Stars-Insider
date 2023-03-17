//
//  CurveTabBar.swift
//  Brawl Stars Insider
//
//  Created by Rajmund Zawiślak on 03/03/2023.
//

import SwiftUI

struct CurveTabBar: View {
    
    @Binding var activeTab: TabItem
    
    private let topBorderWidth = 0.5
    @State private var bottomSafeArea: CGFloat = 0
    
    var body: some View {
        tabItems
            .padding(.bottom, bottomSafeArea == 0 ? 36 : bottomSafeArea)
            .background(tabBarBackground)
            .overlay(bottomOverlay)
            .overlay(alignment: .bottom) {
                Text(activeTab.title)
                    .font(.caption)
                    .foregroundColor(.white)
                    .offset(y: bottomSafeArea == 0 ? -16 : bottomSafeArea + 12)
                    .animation(.linear, value: activeTab)
            }
    }
    
    func firstTabItemAngle(circleDiameter: CGFloat, screenWidth: CGFloat, tabWidth: CGFloat) -> Angle {
        let firstTabPositionX: CGFloat = -(screenWidth - tabWidth) / 2
        let angleInRadians = atan2(circleDiameter, 2 * abs(firstTabPositionX))
        return Angle(radians: angleInRadians - .pi/2)
    }
    
    func activeTabAngle(circleDiameter: CGFloat, tabWidth: CGFloat) -> Angle {
        guard activeTab.rawValue != 0 else {
            return Angle(degrees: 0)
        }
        
        let x = tabWidth * CGFloat(activeTab.rawValue)
        let radians = atan2(circleDiameter, 2 * x)
        return Angle(radians: -radians + .pi/2)
    }

    private var tabItems: some View {
        HStack(spacing: 0) {
            ForEach(TabItem.allCases, id: \.self) { tab in
                tab.image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                    .frame(height: 35)
                    .offset(y: -yOffset(for: tab))
                    .onTapGesture {
                        activeTab = tab
                    }
            }
        }
    }
    
    private var bottomOverlay: some View {
        GeometryReader { reader in
            let frame = reader.frame(in: .global)
            let frameWidth = frame.width
            let circleDiameter = frameWidth * 4.2
            let tabWidth = frameWidth / CGFloat(TabItem.allCases.count)
            let firstTabAngle = firstTabItemAngle(circleDiameter: circleDiameter, screenWidth: frameWidth, tabWidth: tabWidth)
            let activeTabAngle = activeTabAngle(circleDiameter: circleDiameter, tabWidth: tabWidth)
            
            if bottomSafeArea == 0 {
                DispatchQueue.main.async {
                    bottomSafeArea = reader.safeAreaInsets.bottom
                }
            }
            
            return Circle()
                .stroke()
                .fill(.white.opacity(0.3))
                .frame(width: circleDiameter, height: circleDiameter)
                .frame(width: frameWidth)
                .overlay(
                    indicator
                        .offset(y: circleDiameter / -2)
                        .rotationEffect(firstTabAngle)
                        .rotationEffect(activeTabAngle)
                        .animation(.interactiveSpring(response: 0.5, dampingFraction: 0.6, blendDuration: 0), value: activeTab)
                )
                .background(alignment: .top) {
                    Rectangle()
                        .fill(Color.tabBarBackground.gradient)
                        .mask(alignment: .top) {
                            Circle()
                                .frame(width: circleDiameter, height: circleDiameter, alignment: .top)
                        }
                        .frame(width: frameWidth, height: frame.height)
                }
                .offset(y: frame.height / 2.5)
        }
    }
    
    private var tabBarBackground: some View {
        ZStack {
            TabBarShape()
                .fill(Color.tabBarBackground.opacity(0.95).gradient)
            TabBarShape()
                .stroke(lineWidth: topBorderWidth)
                .foregroundColor(.white.opacity(0.8))
                .mask(
                     Rectangle()
                         .offset(y: -25)
                         .padding(.horizontal, topBorderWidth)
                )
        }
    }
    
    private var indicator: some View {
        Capsule()
            .frame(width: 40, height: 4)
            .foregroundColor(.white)
            .intenseShadow(color: .white.opacity(0.5), radius: 60, intensity: 3)
    }
    
    private func yOffset(for tab: TabItem) -> CGFloat {
        let offset = 12
        let allCasesCount = TabItem.allCases.count
        
        if Double(tab.rawValue) / Double(allCasesCount) < 0.5 {
            return CGFloat(tab.rawValue * offset)
        } else {
            return CGFloat((allCasesCount - tab.rawValue - 1) * offset)
        }
    }
}

struct CurveTabBar_Previews: PreviewProvider {
    
    @State static var tab: TabItem = .settings
    
    static var previews: some View {
        ZStack {
            Color.black
                
            VStack {
                Spacer()
                CurveTabBar(activeTab: $tab)
            }
        }
        .ignoresSafeArea()
    }
}
