// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let newReleases = try? newJSONDecoder().decode(NewReleases.self, from: jsonData)
//
// To read values from URLs:
//
//   let task = URLSession.shared.newReleasesTask(with: url) { newReleases, response, error in
//     if let newReleases = newReleases {
//       ...
//     }
//   }
//   task.resume()

import Foundation

// MARK: - NewReleases
public struct NewReleases: Codable {
    public let albums: Albums

    enum CodingKeys: String, CodingKey {
        case albums = "albums"
    }

    public init(albums: Albums) {
        self.albums = albums
    }
}
