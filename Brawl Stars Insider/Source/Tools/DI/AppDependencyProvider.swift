//
//  AppDependencyProvider.swift
//  Brawl Stars Insider
//
//  Created by Rajmund Zawiślak on 23/03/2023.
//

final class AppDependencyProvider: DependencyProvider {
    
    let iconsRepository: IconsRepositoryProtocol = IconsRepository.shared
    
    var brawlifyProvider: Provider<BrawlifyEndpoint> {
        Provider<BrawlifyEndpoint>(decoder: .brawlifyDecoder)
    }

    init() { }
}
