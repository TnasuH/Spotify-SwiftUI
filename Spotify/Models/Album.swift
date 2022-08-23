// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let albumElement = try? newJSONDecoder().decode(AlbumElement.self, from: jsonData)
//
// To read values from URLs:
//
//   let task = URLSession.shared.albumElementTask(with: url) { albumElement, response, error in
//     if let albumElement = albumElement {
//       ...
//     }
//   }
//   task.resume()

import Foundation

// MARK: - Album
public struct Album: Codable {
    public let albumType: String
    public let artists: [Artist]
    public let availableMarkets: [String]
    public let externalUrls: ExternalUrls
    public let href: String
    public let id: String
    public let images: [Image]
    public let name: String
    public let releaseDate: String
    public let releaseDatePrecision: String
    public let totalTracks: Int
    public let type: AlbumTypeEnum?
    public let uri: String

    enum CodingKeys: String, CodingKey {
        case albumType = "album_type"
        case artists = "artists"
        case availableMarkets = "available_markets"
        case externalUrls = "external_urls"
        case href = "href"
        case id = "id"
        case images = "images"
        case name = "name"
        case releaseDate = "release_date"
        case releaseDatePrecision = "release_date_precision"
        case totalTracks = "total_tracks"
        case type = "type"
        case uri = "uri"
    }

    public init(albumType: String, artists: [Artist], availableMarkets: [String], externalUrls: ExternalUrls, href: String, id: String, images: [Image], name: String, releaseDate: String, releaseDatePrecision: String, totalTracks: Int, type: AlbumTypeEnum?, uri: String) {
        self.albumType = albumType
        self.artists = artists
        self.availableMarkets = availableMarkets
        self.externalUrls = externalUrls
        self.href = href
        self.id = id
        self.images = images
        self.name = name
        self.releaseDate = releaseDate
        self.releaseDatePrecision = releaseDatePrecision
        self.totalTracks = totalTracks
        self.type = type
        self.uri = uri
    }
}
