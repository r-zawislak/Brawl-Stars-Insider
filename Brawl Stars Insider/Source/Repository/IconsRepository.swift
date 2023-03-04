//
//  IconsRepository.swift
//  Brawl Stars Insider
//
//  Created by Rajmund Zawiślak on 16/02/2023.
//

import Foundation

enum IconsRepositoryError: Error {
    case noPlayerIcon
    case noClubIcon
}

final class IconsRepository {
    private let store = Store<Icons>(jsonPath: .iconsJSON, defaultValue: Icons())
    private let provider = Provider<BrawlifyEndpoint>()
    
    init() { }
    
    func getPlayerIcon(id: String) async throws -> PlayerIcon {
        if let url = store.item.playerIconForId[id] {
            return url
        } else {
            try await updateClubPlayerIcons()
            return store.item.playerIconForId[id]!
        }
    }
    
    func getClubIcon(id: String) async throws -> ClubIcon {
        if let url = store.item.clubIconForId[id] {
            return url
        } else {
            try await updateClubPlayerIcons()
            return store.item.clubIconForId[id]!
        }
    }
    
    func getBrawler(id: Int) async throws -> Brawler {
        guard !isPreview else {
            return .mock
        }
        
        if let brawler = store.item.brawlerForId[id] {
            return brawler
        } else {
            let response = try await provider.request(.getBrawlers, responseType: ListResponse<Brawler>.self)
            
            store.item.brawlerForId = response.list.reduce(into: [Int : Brawler]()) { dict, element in
                dict[element.id] = element
            }
            
            return store.item.brawlerForId[id]!
        }
    }

    private func updateClubPlayerIcons() async throws {
        let response = try await provider.request(.getIcons, responseType: GetIconsResponse.self)
        
        store.item.clubIconForId = response.club
        store.item.playerIconForId = response.player
    }
}
