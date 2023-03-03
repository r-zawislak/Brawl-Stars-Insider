//
//  Brawl_Stars_InsiderApp.swift
//  Brawl Stars Insider
//
//  Created by Rajmund Zawiślak on 14/02/2023.
//

import SwiftUI

@main
struct Brawl_Stars_InsiderApp: App {
    var body: some Scene {
        WindowGroup {
            EventsView()
                .preferredColorScheme(.dark)
        }
    }
}
