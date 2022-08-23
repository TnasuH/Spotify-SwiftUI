// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let fluffyItem = try? newJSONDecoder().decode(FluffyItem.self, from: jsonData)
//
// To read values from URLs:
//
//   let task = URLSession.shared.fluffyItemTask(with: url) { fluffyItem, response, error in
//     if let fluffyItem = fluffyItem {
//       ...
//     }
//   }
//   task.resume()

import Foundation

// MARK: - FluffyItem
public struct FluffyItem: Codable {
    public let artists: [Artist]
    public let availableMarkets: [String]
    public let discNumber: Int
    public let durationms: Int
    public let explicit: Bool
    public let externalUrls: ExternalUrls
    public let href: String
    public let id: String
    public let isLocal: Bool
    public let name: String
    public let previewurl: String?
    public let trackNumber: Int
    public let type: TrackType
    public let uri: String

    enum CodingKeys: String, CodingKey {
        case artists = "artists"
        case availableMarkets = "available_markets"
        case discNumber = "disc_number"
        case durationms = "duration_ms"
        case explicit = "explicit"
        case externalUrls = "external_urls"
        case href = "href"
        case id = "id"
        case isLocal = "is_local"
        case name = "name"
        case previewurl = "preview_url"
        case trackNumber = "track_number"
        case type = "type"
        case uri = "uri"
    }

    public init(artists: [Artist], availableMarkets: [String], discNumber: Int, durationms: Int, explicit: Bool, externalUrls: ExternalUrls, href: String, id: String, isLocal: Bool, name: String, previewurl: String?, trackNumber: Int, type: TrackType, uri: String) {
        self.artists = artists
        self.availableMarkets = availableMarkets
        self.discNumber = discNumber
        self.durationms = durationms
        self.explicit = explicit
        self.externalUrls = externalUrls
        self.href = href
        self.id = id
        self.isLocal = isLocal
        self.name = name
        self.previewurl = previewurl
        self.trackNumber = trackNumber
        self.type = type
        self.uri = uri
    }
}
