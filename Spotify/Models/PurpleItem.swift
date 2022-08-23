// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let purpleItem = try? newJSONDecoder().decode(PurpleItem.self, from: jsonData)
//
// To read values from URLs:
//
//   let task = URLSession.shared.purpleItemTask(with: url) { purpleItem, response, error in
//     if let purpleItem = purpleItem {
//       ...
//     }
//   }
//   task.resume()

import Foundation

// MARK: - PurpleItem
public struct PurpleItem: Codable {
    public let addedAt: String
    public let addedBy: Owner
    public let isLocal: Bool
    public let primaryColor: String?
    public let track: Track
    public let videoThumbnail: VideoThumbnail

    enum CodingKeys: String, CodingKey {
        case addedAt = "added_at"
        case addedBy = "added_by"
        case isLocal = "is_local"
        case primaryColor = "primary_color"
        case track = "track"
        case videoThumbnail = "video_thumbnail"
    }

    public init(addedAt: String, addedBy: Owner, isLocal: Bool, primaryColor: String?, track: Track, videoThumbnail: VideoThumbnail) {
        self.addedAt = addedAt
        self.addedBy = addedBy
        self.isLocal = isLocal
        self.primaryColor = primaryColor
        self.track = track
        self.videoThumbnail = videoThumbnail
    }
}
