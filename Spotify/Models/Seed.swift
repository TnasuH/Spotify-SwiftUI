// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let seed = try? newJSONDecoder().decode(Seed.self, from: jsonData)
//
// To read values from URLs:
//
//   let task = URLSession.shared.seedTask(with: url) { seed, response, error in
//     if let seed = seed {
//       ...
//     }
//   }
//   task.resume()

import Foundation

// MARK: - Seed
public struct Seed: Codable {
    public let initialPoolSize: Int
    public let afterFilteringSize: Int
    public let afterRelinkingSize: Int
    public let id: String
    public let type: String
    public let href: JSONNull?

    enum CodingKeys: String, CodingKey {
        case initialPoolSize = "initialPoolSize"
        case afterFilteringSize = "afterFilteringSize"
        case afterRelinkingSize = "afterRelinkingSize"
        case id = "id"
        case type = "type"
        case href = "href"
    }

    public init(initialPoolSize: Int, afterFilteringSize: Int, afterRelinkingSize: Int, id: String, type: String, href: JSONNull?) {
        self.initialPoolSize = initialPoolSize
        self.afterFilteringSize = afterFilteringSize
        self.afterRelinkingSize = afterRelinkingSize
        self.id = id
        self.type = type
        self.href = href
    }
}
