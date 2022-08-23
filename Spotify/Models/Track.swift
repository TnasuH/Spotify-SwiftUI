// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let track = try? newJSONDecoder().decode(Track.self, from: jsonData)
//
// To read values from URLs:
//
//   let task = URLSession.shared.trackTask(with: url) { track, response, error in
//     if let track = track {
//       ...
//     }
//   }
//   task.resume()

import Foundation

// MARK: - Track
public struct Track: Codable {
    public let album: Album?
    public let artists: [Artist]?
    public let availableMarkets: [String]?
    public let discNumber: Int?
    public let durationms: Int
    public let episode: Bool?
    public let explicit: Bool
    public let externalids: Externalids
    public let externalUrls: ExternalUrls
    public let href: String
    public let id: String
    public let isLocal: Bool
    public let name: String
    public let popularity: Int
    public let previewurl: String?
    public let trackNumber: Int
    public let type: TrackType
    public let uri: String
    public let restrictions: Restrictions?
    public let images: [Image]?


    enum CodingKeys: String, CodingKey {
        case album = "album"
        case artists = "artists"
        case availableMarkets = "available_markets"
        case discNumber = "disc_number"
        case durationms = "duration_ms"
        case episode = "episode"
        case explicit = "explicit"
        case externalids = "external_ids"
        case externalUrls = "external_urls"
        case href = "href"
        case id = "id"
        case restrictions = "restrictions"
        case isLocal = "is_local"
        case name = "name"
        case popularity = "popularity"
        case previewurl = "preview_url"
        case trackNumber = "track_number"
        case type = "type"
        case uri = "uri"
        case images = "images"
    }

    public init(album: Album?, artists: [Artist]?, availableMarkets: [String]?, discNumber: Int, durationms: Int, episode: Bool?, explicit: Bool, externalids: Externalids, externalUrls: ExternalUrls, href: String, id: String, isLocal: Bool, name: String, popularity: Int, previewurl: String?, track: Bool?, trackNumber: Int, type: TrackType, uri: String, restrictions: Restrictions?, images:[Image]?) {
        self.album = album
        self.artists = artists
        self.availableMarkets = availableMarkets
        self.discNumber = discNumber
        self.durationms = durationms
        self.episode = episode
        self.explicit = explicit
        self.externalids = externalids
        self.externalUrls = externalUrls
        self.href = href
        self.id = id
        self.isLocal = isLocal
        self.name = name
        self.popularity = popularity
        self.previewurl = previewurl
        self.trackNumber = trackNumber
        self.type = type
        self.uri = uri
        self.restrictions = restrictions
        self.images = images
    }
}
