//
//  MapsViewModel.swift
//  Brawl Stars Insider
//
//  Created by Rajmund Zawiślak on 19/03/2023.
//

import Combine
import Foundation

final class MapsViewModel: ObservableObject {
    
    @MainActor @Published var mapsForGameMode: [Event.Map.GameMode : [Event.Map]] = [:]
    @MainActor @Published var gameModes: [Event.Map.GameMode] = []
    @MainActor @Published var activeGameMode: Event.Map.GameMode = .mock
    
    @Dependency(\.brawlifyProvider) private var provider
    
    private let desiredOrder: [GameModeIds] = [.solo, .duo, .gemGrab, .brawlBall, .heist, .hotZone, .bounty, .knockout, .basketBrawl, .duels, .wipeout, .snowtelThieves]
    
    func fetchMaps() async throws {
        guard await gameModes.isEmpty else {
            return
        }
        
        let maps = try await provider.request(.getMaps, responseType: FailableDecodingListResponse<Event.Map>.self).list
        let now = Date.now
        
        let activeMaps = maps.filter {
            guard let lastActive = $0.lastActive else {
                return $0.disabled == false
            }
            
            let lastActiveDate = Date(timeIntervalSince1970: lastActive)
            return $0.disabled == false && now.timeIntervalSince(lastActiveDate) < .days(10) // days, hours, minutes, seconds
        }
        
        let mapsForGameMode = activeMaps.reduce(into: [Event.Map.GameMode : [Event.Map]]()) { dict, element in
            dict[element.gameMode, default: []].append(element)
        }

        let gameModes = sortedGameModes(for: activeMaps)
        
        await MainActor.run {
            self.mapsForGameMode = mapsForGameMode
            self.gameModes = gameModes
            activeGameMode = gameModes.first!
        }
    }
    
    func tabID(for gameMode: Event.Map.GameMode) -> some Hashable {
        gameMode.name
    }
    
    func sectionID(for gameMode: Event.Map.GameMode) -> some Hashable {
        gameMode
    }
    
    private func sortedGameModes(for maps: [Event.Map]) -> [Event.Map.GameMode] {
        let gameModesSet = Set(maps.map(\.gameMode))

        return Array(gameModesSet).sorted { lhs, rhs in
            guard
                let lhsGameMode = GameModeIds(rawValue: lhs.id),
                let rhsGameMode = GameModeIds(rawValue: rhs.id)
            else {
                return lhs.id < rhs.id
            }
            
            guard
                let lhsSortIndex = desiredOrder.firstIndex(of: lhsGameMode),
                let rhsSortIndex = desiredOrder.firstIndex(of: rhsGameMode)
            else {
                return desiredOrder.contains(lhsGameMode)
            }
            
            return lhsSortIndex < rhsSortIndex
        }
    }
}
