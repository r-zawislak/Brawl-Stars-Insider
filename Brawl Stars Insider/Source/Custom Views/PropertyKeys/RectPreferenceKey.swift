//
//  RectPreferenceKey.swift
//  Brawl Stars Insider
//
//  Created by Rajmund Zawiślak on 05/04/2023.
//

import SwiftUI

struct RectPreferenceKey: PreferenceKey {
    static var defaultValue: CGRect = .zero
    
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = nextValue()
    }
}

extension View {
    func rect(in coordinateSpace: CoordinateSpace, completion: @escaping (CGRect) -> Void) -> some View {
        self
            .background(
                GeometryReader { geo in
                    let rect = geo.frame(in: coordinateSpace)
                    
                    Color.clear
                        .preference(key: RectPreferenceKey.self, value: rect)
                        .onPreferenceChange(RectPreferenceKey.self) { newValue in
                            DispatchQueue.main.async {
                                completion(newValue)
                            }
                        }
                }
            )
    }
}
