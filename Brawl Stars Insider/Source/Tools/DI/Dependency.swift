//
//  Dependency.swift
//  Brawl Stars Insider
//
//  Created by Rajmund Zawiślak on 23/03/2023.
//

import SwiftUI

@propertyWrapper
struct Dependency<T> {
    private let keyPath: KeyPath<DependencyProvider, T>
    
    init(_ keyPath: KeyPath<DependencyProvider, T>) {
        self.keyPath = keyPath
    }
    
    var wrappedValue: T {
        let dependencyProvider = BrawlStarsInsiderApp.instance.dependencyProvider
        return dependencyProvider[keyPath: keyPath]
    }
}

