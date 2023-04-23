//
//  GameModeSection.swift
//  Brawl Stars Insider
//
//  Created by Rajmund Zawiślak on 19/04/2023.
//

import SwiftUI
import Kingfisher

struct GameModeSection: View {
    let gameMode: Event.Map.GameMode
    let gameModeMaps: [Event.Map]
    let sectionTitleHeight: CGFloat
    let animation: Namespace.ID
    
    let onMapTapped: (Event.Map) -> Void
    
    var body: some View {
        VStack {
            GameModeView(gameMode: gameMode)
                .font(.title)
                .fontWeight(.semibold)
                .frame(height: sectionTitleHeight)
                .horizontalAlignment(.leading)

            grid(for: gameModeMaps)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .foregroundColor(.secondaryBackground)
        )
    }
    
    private func grid(for maps: [Event.Map]) -> some View {
        LazyVGrid(
            columns: [
                GridItem(.flexible(), spacing: 16),
                GridItem(.flexible(), spacing: 16),
            ],
            spacing: 16
        ) {
            ForEach(maps) { map in
                mapItem(map: map)
                    .onTapGesture {
                        onMapTapped(map)
                    }
            }
        }
    }
    
    private func mapItem(map: Event.Map) -> some View {
        VStack {
            KFImage(map.imageUrl)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .matchedGeometryEffect(id: map.id, in: animation)
            Text(map.name)
        }
    }
}

struct GameModeSection_Previews: PreviewProvider {
    
    @Namespace static var animation
    
    static var previews: some View {
        GameModeSection(gameMode: .mock, gameModeMaps: [.mock, .mock, .mock], sectionTitleHeight: 40, animation: animation) { _ in }
    }
}
