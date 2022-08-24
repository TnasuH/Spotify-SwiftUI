//
//  AlbumViewModel.swift
//  Spotify
//
//  Created by Tarik Nasuhoglu on 24.08.2022.
//

import Foundation
import SwiftUI

class AlbumViewModel: ObservableObject {
    
    @Published var newReleases: [Album] = []
    @Published var featuredPlaylist: [PlaylistsItem] = []
    @Published var recommendations: [Track] = []

    var apiCaller: APICaller = APICaller.shared
    
    init() {
        fetchData()
    }
    
    private func fetchData() {
        let group = DispatchGroup()
        group.enter()
        group.enter()
        group.enter()
        
        var newReleases: NewReleases?
        var featuredPlayList: FeaturedPlaylists?
        var recommendations: Recommendations?
        
        // New Release
        apiCaller.getNewReleases {[weak self] result in
            defer {
                group.leave()
            }
            switch result {
            case .success(let model):
                newReleases = model
            case .failure(let error):
                print("Err!1: \(error)")
            }
        }
        
        // Featured playlist
        apiCaller.getAllFeaturedPlaylists {[weak self] result in
            defer {
                group.leave()
            }
            switch result {
            case .success(let model):
                featuredPlayList = model
                break
            case .failure(let error):
                print("Err!2: \(error)")
                break
            }
        }
        // Recommended tracks
        apiCaller.getGenres {[weak self] result in
            switch result {
            case .success(let model):
                let genres = model.genres
                var seeds = Set<String>()
                while seeds.count < 4 {
                    if let seed = genres.randomElement() {
                        if !seeds.contains(seed){
                            seeds.insert(seed)
                        }
                    }
                }
                self?.apiCaller.getRecommendations(genres: seeds) {[weak self] resultOfRecommended in
                    defer {
                        group.leave()
                    }
                    switch resultOfRecommended {
                    case .success(let model):
                        recommendations = model
                    case .failure(let error):
                        print("Err!3: \(error)")
                    }
                }
            case .failure(let error):
                print("Err!4: \(error)")
            }
        }
        
        group.notify(queue: .main) {
            guard let releases = newReleases?.albums.items,
                  let playList = featuredPlayList?.playlists.items,
                  let tracks = recommendations else {
                      HapticsManager.shared.vibrate(for: .error)
                      fatalError("Models are nil")
                  }
            self.configureModels(newAlbums: releases, playList: playList, tracks: tracks.tracks)
        }
    }
    
    private func configureModels(
        newAlbums: [Album],
        playList: [PlaylistsItem],
        tracks: [Track]
    ) {
        self.newReleases = newAlbums
        self.featuredPlaylist = playList
        self.recommendations = tracks
    }
    
}
