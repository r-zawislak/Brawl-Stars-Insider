//
//  MoyaProvider.swift
//  Brawl Stars Insider
//
//  Created by Rajmund Zawiślak on 14/02/2023.
//

import Moya
import Foundation

var isPreview: Bool {
    ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
}

extension MoyaProvider {
    convenience init(stubClosure: @escaping StubClosure = neverStub) {
        self.init(
            stubClosure: isPreview ? Self.delayedStub(1) : stubClosure,
            plugins: [
                Logger(),
            ]
        )
    }
}
