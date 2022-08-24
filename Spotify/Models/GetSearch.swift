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
