// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let explicitContent = try? newJSONDecoder().decode(ExplicitContent.self, from: jsonData)
//
// To read values from URLs:
//
//   let task = URLSession.shared.explicitContentTask(with: url) { explicitContent, response, error in
//     if let explicitContent = explicitContent {
//       ...
//     }
//   }
//   task.resume()

import Foundation

// MARK: - ExplicitContent
public struct ExplicitContent: Codable {
    public let filterEnabled: Bool
    public let filterLocked: Bool

    enum CodingKeys: String, CodingKey {
        case filterEnabled = "filter_enabled"
        case filterLocked = "filter_locked"
    }

    public init(filterEnabled: Bool, filterLocked: Bool) {
        self.filterEnabled = filterEnabled
        self.filterLocked = filterLocked
    }
}
