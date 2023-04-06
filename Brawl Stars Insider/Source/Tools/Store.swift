//
//  Store.swift
//  Brawl Stars Insider
//
//  Created by Rajmund Zawiślak on 16/02/2023.
//
import Foundation

actor Store<T: Codable> {
    private(set) var item: T
    
    private let jsonURL: URL

    init(jsonPath: AppPath, defaultValue: T) {
        jsonURL = jsonPath.rawValue
        item = defaultValue
        Task {
            await read()
        }
    }

    func updateItem(_ newItem: T) async {
        item = newItem
        await save()
    }
    
    func updateItem(with updateClosure: (inout T) -> Void) async {
        updateClosure(&item)
        await save()
    }

    private func save() async {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted

        do {
            let data = try encoder.encode(item)
            try data.write(to: jsonURL, options: .atomic)
        } catch {
            Logger().log(error, logType: .error)
        }
    }

    private func read() async {
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
}
