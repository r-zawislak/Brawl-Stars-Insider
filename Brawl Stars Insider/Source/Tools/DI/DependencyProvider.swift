//
//  DependencyProvider.swift
//  Brawl Stars Insider
//
//  Created by Rajmund Zawiślak on 23/03/2023.
//

protocol DependencyProvider {
    var iconsRepository: IconsRepositoryProtocol { get }
    var brawlifyProvider: Provider<BrawlifyEndpoint> { get }
}
