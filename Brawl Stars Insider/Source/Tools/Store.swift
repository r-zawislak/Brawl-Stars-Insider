//
//  Store.swift
//  Brawl Stars Insider
//
//  Created by Rajmund Zawiślak on 16/02/2023.
//

import Foundation

class Store<T: Codable> {
    
    private let jsonURL: URL
    private let queue = DispatchQueue(label: "pl.zawislak.store", attributes: .concurrent)
    private var isSaving = false
    
    var item: T {
        didSet {
            save()
        }
    }
    
    init(jsonPath: AppPath, defaultValue: T) {
        jsonURL = jsonPath.rawValue
        item = defaultValue
        read()
    }
    
    func save() {
        queue.async(flags: .barrier) { [weak self] in
            guard
                let strongSelf = self,
                strongSelf.isSaving
            else {
                return
            }
            
            strongSelf.isSaving = true
            
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            
            do {
                let data = try encoder.encode(strongSelf.item)
                try data.write(to: strongSelf.jsonURL, options: .atomic)
            } catch {
                Logger().log(error, logType: .error)
            }
            
            strongSelf.isSaving = false
        }
    }
    
    private func read() {
        queue.async { [self] in
            let fileManager = FileManager.default
            let path = jsonURL.path
            
            if fileManager.fileExists(atPath: path) {
                do {
                    let data = try Data(contentsOf: jsonURL, options: .mappedIfSafe)
                    
                    guard !data.isEmpty else { return }
                    
                    self.item = try JSONDecoder().decode(T.self, from: data)
                } catch {
                    Logger().log(error, logType: .error)
                }
            } else {
                fileManager.createFile(atPath: path, contents: nil)
            }
        }
    }
    
    deinit {
        save()
    }
}
