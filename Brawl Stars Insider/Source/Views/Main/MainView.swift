//
//  MainView.swift
//  Brawl Stars Insider
//
//  Created by Rajmund Zawiślak on 12/03/2023.
//

import SwiftUI

struct MainView: View {
    
    @State private var activeTab: TabItem = .events
    private let eventsView = EventsView()
    private let mapsView = MapsView()
    private let brawlersView = BrawlersView()
    private let settingsView = SettingsView()
    
    var body: some View {
        ZStack {
            tabItemView
            
            VStack {
                Spacer()
                
                CurveTabBar(activeTab: $activeTab)
            }
            .ignoresSafeArea(.all, edges: .bottom)
        }
    }
    
    @ViewBuilder
    private var tabItemView: some View {
        switch activeTab {
        case .events:
            eventsView
        case .maps:
            mapsView
        case .brawlers:
            brawlersView
        case .settings:
            settingsView
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .preferredColorScheme(.dark)
    }
}
