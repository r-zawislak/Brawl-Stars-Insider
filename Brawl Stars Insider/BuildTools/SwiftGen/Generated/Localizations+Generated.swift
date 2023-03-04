// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation
import SwiftUI

// MARK: - Plist Files
internal enum Localizations {
        internal enum Events {
          static var key: String { return "events" }
          internal enum Row {
            static var key: String { return "events.row" }
            /*
            Ends in {0}
            */
            internal enum EndsIn {
                static var key: String { return "events.row.endsIn" }
                static func localized(p0: String) -> String { return "events.row.endsIn".localized(parameters: [p0]) }
            }
            /*
            Recommended
            */
            internal enum Recommended {
                static var key: String { return "events.row.recommended" }
                static var localized: String { "events.row.recommended".localized() }
            }
          }
          /*
          Events
          */
          internal enum Title {
              static var key: String { return "events.title" }
              static var localized: String { "events.title".localized() }
          }
        }
}
// swiftlint:enable all

extension String {
    // MARK: - Localization
    func localized(parameters: [String] = [], prefix: String = "") -> String {
        let logMessage = "Missing localization key: \(self)"
        var keys = components(separatedBy: ".")
        guard
            let path = Bundle.main.path(forResource: "\(prefix)Localizations", ofType: "plist"),
            let dictionary = NSDictionary(contentsOfFile: path),
            let valueKey = keys.popLast()
        else {
            print(logMessage)
            return ""
        }
        var searchDictionary: NSDictionary? = dictionary
        for key in keys {
            searchDictionary = searchDictionary?[key] as? NSDictionary
        }
        guard var string = searchDictionary?[valueKey] as? String else {
            print(logMessage)
            return ""
        }
        if !parameters.isEmpty {
            for (index, parameterString) in parameters.enumerated() {
                string = string.replacingOccurrences(of: "{\(index)}", with: parameterString)
            }
        }
        return string.replacingOccurrences(of: "\\n", with: "\n")
    }
    var markdowned: LocalizedStringKey {
        LocalizedStringKey(self)
    }
}
