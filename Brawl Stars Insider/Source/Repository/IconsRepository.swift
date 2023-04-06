//
//  IconsRepository.swift
//  Brawl Stars Insider
//
//  Created by Rajmund Zawiślak on 16/02/2023.
//


import Foundation

protocol IconsRepositoryProtocol {
    func getPlayerIcon(id: String) async throws -> PlayerIcon
    func getClubIcon(id: String) async throws -> ClubIcon
    func getBrawler(id: Int) async throws -> Brawler
}

enum IconsRepositoryError: Error {
    case noPlayerIcon
    case noClubIcon
    case noBrawler
}

@globalActor
final actor IconsRepository: IconsRepositoryProtocol {
    static let shared = IconsRepository()
    private let store: Store<Icons>
    private let provider: Provider<BrawlifyEndpoint>

    init() {
        store = .init(jsonPath: .iconsJSON, defaultValue: Icons())
        provider = .init()
    }

    func getPlayerIcon(id: String) async throws -> PlayerIcon {
        if let icon = await store.item.playerIconForId[id] {
            return icon
        } else {
            try await updateClubPlayerIcons()
            guard let playerIcon = await store.item.playerIconForId[id] else {
                throw IconsRepositoryError.noPlayerIcon
            }
            return playerIcon
        }
    }

    func getClubIcon(id: String) async throws -> ClubIcon {
        if let icon = await store.item.clubIconForId[id] {
            return icon
        } else {
            try await updateClubPlayerIcons()
            guard let clubIcon = await store.item.clubIconForId[id] else {
                throw IconsRepositoryError.noClubIcon
            }
            return clubIcon
        }
    }

    func getBrawler(id: Int) async throws -> Brawler {
        if let brawler = await store.item.brawlerForId[id] {
            return brawler
        } else {
            if await store.item.brawlerForId.isEmpty {
                try await fetchAllBrawlers()
            } else {
                let brawler = try await provider.request(.getBrawler(id: id), responseType: Brawler.self)
                await store.updateItem {
                    $0.brawlerForId[brawler.id] = brawler
                }
            }
        }
        
        guard let brawler = await store.item.brawlerForId[id] else {
            throw IconsRepositoryError.noBrawler
        }
        
        return brawler
    }
    
    private func fetchAllBrawlers() async throws {
        let response = try await provider.request(.getAllBrawlers, responseType: ListResponse<Brawler>.self)
        
        let brawlerForId = response.list.reduce(into: [Int : Brawler]()) { dict, element in
            dict[element.id] = element
        }
        
        await store.updateItem {
            $0.brawlerForId = brawlerForId
        }
    }

    private func updateClubPlayerIcons() async throws {
        let response = try await provider.request(.getIcons, responseType: GetIconsResponse.self)

        await store.updateItem {
            $0.clubIconForId = response.club
            $0.playerIconForId = response.player
        }
    }
}
