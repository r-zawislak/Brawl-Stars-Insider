//
//  GameModeView.swift
//  Brawl Stars Insider
//
//  Created by Rajmund Zawiślak on 19/04/2023.
//

import SwiftUI
import Kingfisher

struct GameModeView: View {
    
    let gameMode: Event.Map.GameMode
    
    var body: some View {
        HStack {
            KFImage(gameMode.imageUrl)
                .resizable()
                .aspectRatio(contentMode: .fit)
            Text(gameMode.name)
                .foregroundColor(.white)
        }
    }
}

struct GameModeView_Previews: PreviewProvider {
    static var previews: some View {
        GameModeView(gameMode: .mock)
    }
}
