//
//  GetSearch.swift
//  Spotify
//
//  Created by Tarık Nasuhoğlu on 25.10.2021.
//

import Foundation

struct GetSearch: Codable {
    let tracks: Tracks
    let artists: Artists
    let albums: Albums
    let playlists: Playlists
}

enum SearchResult {
    case track(model: Track)
    case artist(model: Artist)
    case album(model: Album)
    case playlist(model: PlaylistsItem)
}
