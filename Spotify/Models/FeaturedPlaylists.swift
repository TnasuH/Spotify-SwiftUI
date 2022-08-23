// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let featuredPlaylists = try? newJSONDecoder().decode(FeaturedPlaylists.self, from: jsonData)
//
// To read values from URLs:
//
//   let task = URLSession.shared.featuredPlaylistsTask(with: url) { featuredPlaylists, response, error in
//     if let featuredPlaylists = featuredPlaylists {
//       ...
//     }
//   }
//   task.resume()

import Foundation

// MARK: - FeaturedPlaylists
public struct FeaturedPlaylists: Codable {
    public let message: String
    public let playlists: Playlists

    enum CodingKeys: String, CodingKey {
        case message = "message"
        case playlists = "playlists"
    }

    public init(message: String, playlists: Playlists) {
        self.message = message
        self.playlists = playlists
    }
}
