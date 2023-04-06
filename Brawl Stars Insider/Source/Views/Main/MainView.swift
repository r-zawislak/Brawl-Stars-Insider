//
//  MainView.swift
//  Brawl Stars Insider
//
//  Created by Rajmund Zawiślak on 12/03/2023.
//

import SwiftUI

struct MainView: View {
    
    @State private var activeTab: TabItem = .events
    
    var body: some View {
        ZStack {
            tabView
            tabBar
        }
    }

    private var tabView: some View {
        TabView(selection: $activeTab) {
            EventsView()
                .tag(TabItem.events)
                .toolbar(.hidden, for: .tabBar)
            MapsView()
                .tag(TabItem.maps)
                .toolbar(.hidden, for: .tabBar)
            BrawlersView()
                .tag(TabItem.brawlers)
                .toolbar(.hidden, for: .tabBar)
            SettingsView()
                .tag(TabItem.settings)
                .toolbar(.hidden, for: .tabBar)
        }
    }
    
    private var tabBar: some View {
        VStack {
            Spacer()
            
            CurveTabBar(activeTab: $activeTab)
        }
        .ignoresSafeArea(.all, edges: .bottom)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .preferredColorScheme(.dark)
    }
}
