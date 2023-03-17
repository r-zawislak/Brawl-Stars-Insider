//
//  BrawlerStatView.swift
//  Brawl Stars Insider
//
//  Created by Rajmund Zawiślak on 17/02/2023.
//

import SwiftUI
import Kingfisher

struct BrawlerStatView: View {
    let stat: Event.Map.Stat
    let icons = IconsRepository()
    
    @State private var brawler: Brawler?
    private let borderWidth: CGFloat = 2
    
    var body: some View {
        image
            .overlay(winRateOverlay)
            .task {
                brawler = try! await icons.getBrawler(id: stat.brawler)
            }
    }
    
    private var image: some View {
        KFImage(brawler?.imageUrl2)
            .resizable()
            .scaledToFit()
            .clipShape(Circle())
            .overlay(
                Circle()
                    .stroke(rarityColor, lineWidth: borderWidth)
            )
    }
    
    private var rarityColor: some ShapeStyle {
        if brawler?.rarity.name == "Chromatic" {
            return AnyShapeStyle(LinearGradient.chromatic)
        } else {
            guard let hex = brawler?.rarity.color else {
                return AnyShapeStyle(.clear)
            }

            return AnyShapeStyle(Color(hex: hex))
        }
    }
    
    private var winRateOverlay: some View {
        GeometryReader { reader in
            HStack {
                Spacer()
                winRate
                    .frame(height: 20)
                    .padding(.top, -6)
                Spacer()
            }
        }
    }
    
    private var winRate: some View {
        Text(String(format: "%.0f%%", stat.winRate))
            .bold()
            .foregroundStyle(rarityColor)
            .minimumScaleFactor(0.2)
            .padding(4)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .foregroundColor(.secondaryBackground)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(lineWidth: borderWidth)
                            .fill(rarityColor)
                    )
            )
    }
}

struct BrawlerStatView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.secondaryBackground
            BrawlerStatView(stat: .mock)
                .frame(width: 128, height: 128)
        }
        .preferredColorScheme(.dark)
        
    }
}
