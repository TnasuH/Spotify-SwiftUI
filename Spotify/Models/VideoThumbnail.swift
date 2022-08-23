// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let videoThumbnail = try? newJSONDecoder().decode(VideoThumbnail.self, from: jsonData)
//
// To read values from URLs:
//
//   let task = URLSession.shared.videoThumbnailTask(with: url) { videoThumbnail, response, error in
//     if let videoThumbnail = videoThumbnail {
//       ...
//     }
//   }
//   task.resume()

import Foundation

// MARK: - VideoThumbnail
public struct VideoThumbnail: Codable {
    public let url: JSONNull?

    enum CodingKeys: String, CodingKey {
        case url = "url"
    }

    public init(url: JSONNull?) {
        self.url = url
    }
}
