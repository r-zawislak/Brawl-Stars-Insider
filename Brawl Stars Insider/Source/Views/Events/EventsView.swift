//
//  EventsView.swift
//  Brawl Stars Insider
//
//  Created by Rajmund Zawiślak on 14/02/2023.
//

import SwiftUI

struct EventsView: View {
    @StateObject var viewModel = EventsViewModel()
    
    private let localizations = Localizations.Events.self
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.background
                    .ignoresSafeArea()
                content
            }
            .navigationTitle(localizations.Title.localized)
        }

        .task {
            try? await viewModel.fetchEvents()
        }
    }
    
    private var content: some View {
        list
    }
    
    private var list: some View {
        ScrollView(.vertical) {
            LazyVStack {
                ForEach(viewModel.events, id: \.map.id) {
                    EventRow(event: $0)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EventsView()
    }
}
