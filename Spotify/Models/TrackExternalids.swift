// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let trackExternalids = try? newJSONDecoder().decode(TrackExternalids.self, from: jsonData)
//
// To read values from URLs:
//
//   let task = URLSession.shared.trackExternalidsTask(with: url) { trackExternalids, response, error in
//     if let trackExternalids = trackExternalids {
//       ...
//     }
//   }
//   task.resume()

import Foundation

// MARK: - TrackExternalids
public struct TrackExternalids: Codable {
    public let isrc: String

    enum CodingKeys: String, CodingKey {
        case isrc = "isrc"
    }

    public init(isrc: String) {
        self.isrc = isrc
    }
}
