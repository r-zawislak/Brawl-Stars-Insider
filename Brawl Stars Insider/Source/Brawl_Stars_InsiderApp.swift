//
//  Brawl_Stars_InsiderApp.swift
//  Brawl Stars Insider
//
//  Created by Rajmund Zawiślak on 14/02/2023.
//

import SwiftUI
import Kingfisher

var isRunningTests: Bool {
    ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil
}

var isRunningPreview: Bool {
    ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
}

@main
struct BrawlStarsInsiderApp: App {
    
    static private(set) var instance: BrawlStarsInsiderApp!
    
    let dependencyProvider: DependencyProvider
    
    init() {
        if isRunningPreview || isRunningTests {
            dependencyProvider = MockDependencyProvider()
        } else {
            dependencyProvider = AppDependencyProvider()
        }
        
        Self.instance = self
        
        configureKingfisher()
    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .preferredColorScheme(.dark)
        }
    }
    
    private func configureKingfisher() {
        let cache = KingfisherManager.shared.cache
        cache.memoryStorage.config.totalCostLimit = 50 * 1024 * 1024
    }
}
