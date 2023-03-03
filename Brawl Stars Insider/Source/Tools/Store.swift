//
//  Store.swift
//  Brawl Stars Insider
//
//  Created by Rajmund Zawiślak on 16/02/2023.
//

import Foundation

class Store<T: Codable> {
    
    var item: T {
        didSet {
            save()
        }
    }
    
    private let jsonURL: URL
    
    init(jsonPath: AppPath, defaultValue: T) {
        jsonURL = jsonPath.rawValue
        item = defaultValue
        read()
    }
    
    func save() {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        do {
            let data = try encoder.encode(item)
            try data.write(to: jsonURL, options: .atomic)
        } catch {
            Logger().log(error, logType: .error)
        }
    }
    
    private func read() {
        let fileManager = FileManager.default
        let path = jsonURL.path
        
        if fileManager.fileExists(atPath: path) {
            do {
                let data = try Data(contentsOf: jsonURL, options: .mappedIfSafe)
                
                guard !data.isEmpty else { return }
                
                item = try JSONDecoder().decode(T.self, from: data)
            } catch {
                Logger().log(error, logType: .error)
            }
        } else {
            fileManager.createFile(atPath: path, contents: nil)
        }
    }
    
    deinit {
        save()
    }
}
