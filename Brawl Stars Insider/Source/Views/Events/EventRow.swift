//
//  EventRow.swift
//  Brawl Stars Insider
//
//  Created by Rajmund Zawiślak on 16/02/2023.
//

import SwiftUI
import Kingfisher

struct EventRow: View {
    
    let event: Event
    
    @StateObject private var viewModel: EventRowViewModel
    
    private let cornerRadius: CGFloat = 24
    private let lineWidth: CGFloat = 1
    private let localizations = Localizations.Events.Row.self
    
    private var mapBackgroundColor: Color { Color(hex: event.map.gameMode.bgColor)
    }
    
    init(event: Event) {
        self.event = event
        let vm = EventRowViewModel(event: event)
        _viewModel = StateObject(wrappedValue: vm)
    }
    
    var body: some View {
        ZStack {
            Color.secondaryBackground
            VStack(spacing: 0) {
                header
                content
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 150)
        .cornerRadius(cornerRadius)
        .padding(lineWidth)
        .overlay(
            RoundedRectangle(cornerRadius: cornerRadius)
                .inset(by: lineWidth)
                .stroke(lineWidth: lineWidth)
                .foregroundColor(mapBackgroundColor)
        )
    }
    
    private var header: some View {
        HStack(alignment: .center) {
            KFImage(event.map.gameMode.imageUrl)
                .resizable()
                .scaledToFit()
                .frame(width: 32, height: 32)
            VStack(alignment: .leading) {
                Text(event.map.gameMode.name.uppercased())
                    .bold()
                Text(event.map.name)
                    .font(.subheadline)
            }
            
            
            Spacer()
            Text(viewModel.eventEndsInString)
                .padding(.trailing, 8)
        }
        .padding([.top, .leading], 4)
        .padding(.bottom, 4)
        .background(mapBackgroundColor)
    }
    
    private var content: some View {
        recommendedBrawlers
    }
            
    private var recommendedBrawlers: some View {
        VStack(alignment: .leading) {
            Text(localizations.Recommended.localized)
                .bold()
            HStack(spacing: 16) {
                ForEach(viewModel.recommended, id: \.brawler) {
                    BrawlerStatView(stat: $0)
                }
                
                Spacer()
            }
            
        }
        .padding(8)
    }
}

struct EventRow_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.background
            EventRow(event: .mock)
        }
        .preferredColorScheme(.dark)
    }
}
