//
//  MockDependencyProvider.swift
//  Brawl Stars Insider
//
//  Created by Rajmund Zawiślak on 23/03/2023.
//

import Foundation

final class MockDependencyProvider: DependencyProvider {
    let iconsRepository: IconsRepositoryProtocol = IconsRepositoryMock()
    
    var brawlifyProvider: Provider<BrawlifyEndpoint> = .init()
    
    private let iconsStore = Store<Icons>(jsonPath: .iconsJSON, defaultValue: Icons())
    
    init() {
        
    }
}
