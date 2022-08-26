//
//  AlbumViewModel.swift
//  Spotify
//
//  Created by Tarik Nasuhoglu on 24.08.2022.
//

import Foundation
import SwiftUI

class AlbumViewModel: ObservableObject {
    
    @Published var recommendationState: FetchState = .good
    @Published var recommendations: Recommendations = Recommendations(tracks: [], seeds: [])

    
    @Published var newReleasesState: FetchState = .good
    @Published var newReleasesAlbum: Albums = Albums(href: "", items: [], limit: 20, next: nil, offset: 0, previous: nil, total: 0)
    
    @Published var featuredPlaylistState: FetchState = .good
    @Published var featuredPlaylist: FeaturedPlaylists = FeaturedPlaylists(message: "", playlists: Playlists(href: "", items: [], limit: 20, next: nil, offset: 0, previous: nil, total: 0))

    
    var apiCaller: APICaller = APICaller.shared
    
    init() {
        getNewReleases()
        getFeaturedPlaylists()
        getRecommendations()
    }
    
    private func getRecommendations() {
        guard recommendationState == .good else {
            return
        }
        
        self.recommendationState = .isLoading
        
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
                    switch resultOfRecommended {
                    case .success(let model):
                        DispatchQueue.main.async {
                            self?.recommendations = model
                            self?.recommendationState = .loadedAll
                        }
                    case .failure(let error):
                        self?.recommendationState = .error(error.localizedDescription)
                        print("Err!3: \(error)")
                    }
                }
            case .failure(let error):
                self?.recommendationState = .error(error.localizedDescription)
                print("Err!4: \(error)")
            }
        }
    }
    
    public func loadMoreNewReleases() {
        guard newReleasesState == FetchState.good else {
            return
        }
        self.newReleasesState = .isLoading
        let a = newReleasesAlbum
        apiCaller.getNewReleases(offset: a.items.count, limit: a.limit) { [weak self]result in
            switch result {
            case .success(let model):
                DispatchQueue.main.async {
                    self?.newReleasesAlbum.items.append(contentsOf: model.albums.items)
                    let resultTotal = self?.newReleasesAlbum.items.count ?? 0
                    self?.newReleasesState = (resultTotal < (model.albums.total )) ? .good : .loadedAll
                }
            case .failure(let error):
                print("Err!1: \(error)")
            }
        }
    }
    
    private func getNewReleases() {
        guard newReleasesState == FetchState.good else {
            return
        }
        self.newReleasesState = .isLoading
        let a = newReleasesAlbum
        apiCaller.getNewReleases(offset: a.offset, limit: a.limit) {[weak self] result in
            switch result {
            case .success(let model):
                DispatchQueue.main.async {
                    self?.newReleasesAlbum = model.albums
                    let resultTotal = self?.newReleasesAlbum.items.count ?? 0
                    self?.newReleasesState = (resultTotal < (model.albums.total )) ? .good : .loadedAll
                }
            case .failure(let error):
                print("Err!1: \(error)")
            }
        }
    }
    
    private func getFeaturedPlaylists(){
        guard featuredPlaylistState == FetchState.good else {
            return
        }
        self.featuredPlaylistState = .isLoading
        let a = featuredPlaylist
        apiCaller.getAllFeaturedPlaylists(limit: a.playlists.limit, offset: a.playlists.items.count) {[weak self] result in
            switch result {
            case .success(let model):
                DispatchQueue.main.async {
                    self?.featuredPlaylist = model
                    let resultTotal = self?.featuredPlaylist.playlists.items.count ?? 0
                    self?.featuredPlaylistState = (resultTotal < (model.playlists.total )) ? .good : .loadedAll
                }
                break
            case .failure(let error):
                print("Err!2: \(error)")
                break
            }
        }
    }
    
    public func loadMoreFeaturedPlaylists(){
        
        guard featuredPlaylistState == FetchState.good else {
            return
        }
        
        self.featuredPlaylistState = .isLoading
        let a = featuredPlaylist
        
        apiCaller.getAllFeaturedPlaylists(limit: a.playlists.limit, offset: a.playlists.items.count) { [weak self] result in
            switch result {
            case .success(let model):
                DispatchQueue.main.async {
                    self?.featuredPlaylist.playlists.items.append(contentsOf: model.playlists.items)
                    let resultTotal = self?.featuredPlaylist.playlists.items.count ?? 0
                    self?.featuredPlaylistState = (resultTotal < (model.playlists.total )) ? .good : .loadedAll
                }
                break
            case .failure(let error):
                print("Err!2: \(error)")
                break
            }
        }
    }
    
    private func fetchData() {
        let group = DispatchGroup()
        group.enter()
        group.enter()
        group.enter()
        
        var newReleases: NewReleases?
        var featuredPlayList: FeaturedPlaylists?
        var recommendations: Recommendations?
        
        // Featured playlist
        
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
                  //let playList = featuredPlayList?.playlists.items,
                  let tracks = recommendations else {
                      HapticsManager.shared.vibrate(for: .error)
                        fatalError("Models are nil")
                  }
            //self.configureModels(newAlbums: releases, playList: playList, tracks: tracks.tracks)
        }
    }
    
    private func configureModels(
        newAlbums: [Album],
        playList: [PlaylistsItem],
        tracks: [Track]
    ) {
//        self.newReleases = newAlbums
      //  self.featuredPlaylist = playList
      //  self.recommendations = tracks
    }
    
}
