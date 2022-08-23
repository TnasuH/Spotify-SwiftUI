// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let getPlaylists = try? newJSONDecoder().decode(GetPlaylists.self, from: jsonData)
//
// To read values from URLs:
//
//   let task = URLSession.shared.getPlaylistsTask(with: url) { getPlaylists, response, error in
//     if let getPlaylists = getPlaylists {
//       ...
//     }
//   }
//   task.resume()

import Foundation

// MARK: - GetPlaylists
public struct GetPlaylists: Codable {
    public let collaborative: Bool
    public let getPlaylistsDescription: String
    public let externalUrls: ExternalUrls
    public let followers: Followers
    public let href: String
    public let id: String
    public let images: [Image]
    public let name: String
    public let owner: Owner
    public let primaryColor: String?
    public let getPlaylistsPublic: Bool
    public let snapshotid: String
    public var tracks: GetPlaylistsTracks
    public let type: GetPlaylistsType
    public let uri: String

    enum CodingKeys: String, CodingKey {
        case collaborative = "collaborative"
        case getPlaylistsDescription = "description"
        case externalUrls = "external_urls"
        case followers = "followers"
        case href = "href"
        case id = "id"
        case images = "images"
        case name = "name"
        case owner = "owner"
        case primaryColor = "primary_color"
        case getPlaylistsPublic = "public"
        case snapshotid = "snapshot_id"
        case tracks = "tracks"
        case type = "type"
        case uri = "uri"
    }

    public init(collaborative: Bool, getPlaylistsDescription: String, externalUrls: ExternalUrls, followers: Followers, href: String, id: String, images: [Image], name: String, owner: Owner, primaryColor: String?, getPlaylistsPublic: Bool, snapshotid: String, tracks: GetPlaylistsTracks, type: GetPlaylistsType, uri: String) {
        self.collaborative = collaborative
        self.getPlaylistsDescription = getPlaylistsDescription
        self.externalUrls = externalUrls
        self.followers = followers
        self.href = href
        self.id = id
        self.images = images
        self.name = name
        self.owner = owner
        self.primaryColor = primaryColor
        self.getPlaylistsPublic = getPlaylistsPublic
        self.snapshotid = snapshotid
        self.tracks = tracks
        self.type = type
        self.uri = uri
    }
}
