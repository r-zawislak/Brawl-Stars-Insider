//
//  AppPath.swift
//  Brawl Stars Insider
//
//  Created by Rajmund Zawiślak on 16/02/2023.
//

import Foundation

struct AppPath: RawRepresentable {
    
    static var documentsPath: AppPath {
        let supportPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return AppPath(rawValue: supportPath)
    }
    
    static var cachePath: AppPath {
        let cachePath = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        return AppPath(rawValue: cachePath)
    }
    
    static var iconsJSON: AppPath {
        cachePath.appending("imageCaches.json")
    }
    
    var rawValue: URL
    
    init(rawValue: URL) {
        self.rawValue = rawValue
    }
    
    private func appending(_ path: String, isDirectory: Bool = false) -> AppPath {
        AppPath(rawValue: rawValue.appendingPathComponent(path, isDirectory: isDirectory))
    }
}
