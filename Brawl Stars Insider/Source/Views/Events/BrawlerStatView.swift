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
    
    private var rarityColor: Color {
        guard let hex = brawler?.rarity.color else {
            return .clear
        }
        
        return Color(hex: hex)
    }
    
    private let borderWidth: CGFloat = 2
    
    var body: some View {
        image
            .overlay(overlay)
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
    
    private var overlay: some View {
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
            .foregroundColor(rarityColor)
            .minimumScaleFactor(0.2)
            .padding(4)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .foregroundColor(.secondaryBackground)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(rarityColor, lineWidth: borderWidth)
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

struct CircleImageWithText: View {
    var image: Image
    var text: String
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.white, lineWidth: 2)
                .background(
                    Circle()
                        .fill(Color.white)
                        .shadow(radius: 5)
                )
            image
                .resizable()
                .scaledToFit()
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 2))
            Text(text)
                .foregroundColor(.white)
                .font(.system(size: 20, weight: .bold))
                .padding()
                .background(
                    Circle()
                        .fill(Color.white)
                        .padding(5)
                )
        }
    }
}
