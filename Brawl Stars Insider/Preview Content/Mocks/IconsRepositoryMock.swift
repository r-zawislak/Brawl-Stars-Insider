//
//  IconsRepositoryMock.swift
//  Brawl Stars Insider
//
//  Created by Rajmund Zawiślak on 31/03/2023.
//

import Foundation

final class IconsRepositoryMock: IconsRepositoryProtocol {
    func getPlayerIcon(id: String) async throws -> PlayerIcon {
        .mock
    }
    
    func getClubIcon(id: String) async throws -> ClubIcon {
        .mock
    }
    
    func getBrawler(id: Int) async throws -> Brawler {
        .mock
    }
}
