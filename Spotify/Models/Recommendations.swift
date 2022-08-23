// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let recommendations = try? newJSONDecoder().decode(Recommendations.self, from: jsonData)
//
// To read values from URLs:
//
//   let task = URLSession.shared.recommendationsTask(with: url) { recommendations, response, error in
//     if let recommendations = recommendations {
//       ...
//     }
//   }
//   task.resume()

import Foundation

// MARK: - Recommendations
public struct Recommendations: Codable {
    public let tracks: [Track]
    public let seeds: [Seed]

    enum CodingKeys: String, CodingKey {
        case tracks = "tracks"
        case seeds = "seeds"
    }

    public init(tracks: [Track], seeds: [Seed]) {
        self.tracks = tracks
        self.seeds = seeds
    }
}
