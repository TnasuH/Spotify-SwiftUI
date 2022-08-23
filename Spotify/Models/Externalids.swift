// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let externalids = try? newJSONDecoder().decode(Externalids.self, from: jsonData)

import Foundation

// MARK: - Externalids
public struct Externalids: Codable {
    public let isrc: String

    enum CodingKeys: String, CodingKey {
        case isrc
    }

    public init(isrc: String) {
        self.isrc = isrc
    }
}
