//
//  SearchViewModel.swift
//  Spotify
//
//  Created by Tarik Nasuhoglu on 24.08.2022.
//

import Foundation
import Combine
import SwiftUI

class SearchViewModel: ObservableObject {
    
    @Published var searchTerm: String = ""
    @Published var categories: [CategoryItem] = []
    
    private var searchResult: GetSearch?
    
    @Published var artists: [Artist] = []
    @Published var tracks: [Track] = []
    @Published var playlists: [PlaylistsItem] = []
    @Published var albums: [Album] = []
    
    @Published var state: FetchState = .good
    
    let limit: Int = 20
    var offset: Int = 0
    
    var apiCaller: APICaller = APICaller.shared
    
    var subscriptions = Set<AnyCancellable>()
    
    init() {
        $searchTerm
        //                .dropFirst()
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink { [weak self] term in
                self?.clear()
                self?.state = .good
                self?.searchResult = nil
                self?.fetchSearchResult(for: term, type: "artist")
                
            }.store(in: &subscriptions)
        
        self.fetchCategoriesData()
        
        
    }
    
    func clear() {
        state = .good
        albums = []
        artists = []
        tracks = []
        playlists = []
        offset = 0
    }
    
    func loadMore(type: String) {
        fetchSearchResult(for: searchTerm, type: type)
    }
    
    func fetchSearchResult(for query: String, type: String) {
        guard !searchTerm.isEmpty else {
            return
        }
        guard state == FetchState.good else {
            return
        }
        
        self.state = .isLoading
        
        apiCaller.search(with: query, limit: limit, offset: offset, type: type) {[weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let results):
                    self?.searchResult = results
                    
                    var resultTotal = 0
                    
                    if type == EntityType.artist.id {
                        results.artists.items.forEach { item in
                            self?.artists.append(item)
                        }
                        resultTotal = self?.artists.count ?? 0
                        self?.state = (resultTotal < (results.artists.total )) ? .good : .loadedAll
                        
                    }
                    
                    if type == EntityType.track.id {
                        results.tracks.items.forEach { item in
                            self?.tracks.append(item)
                        }
                        resultTotal = self?.artists.count ?? 0
                        self?.state = (resultTotal < (results.tracks.total)) ? .good : .loadedAll
                    }
                    
                    if type == EntityType.album.id {
                        results.albums.items.forEach { item in
                            self?.albums.append(item)
                        }
                        resultTotal = self?.artists.count ?? 0
                        self?.state = (resultTotal < (results.albums.total )) ? .good : .loadedAll
                    }
                    
                    if type == EntityType.playlist.id {
                        results.playlists.items.forEach { item in
                            self?.playlists.append(item)
                        }
                        resultTotal = self?.artists.count ?? 0
                        self?.state = (resultTotal < (results.playlists.total )) ? .good : .loadedAll
                        
                    }
                    
                    self?.offset += (1 * (self?.limit ?? 20))
                    
                case .failure(let error):
                    self?.state = .error(error.localizedDescription)
                    print(error.localizedDescription)
                    HapticsManager.shared.vibrate(for: .error)
                }
            }
        }
    }
    
    private func fetchCategoriesData() {
        // Categories
        self.apiCaller.getCategories {[weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    self?.categories = model
                case .failure(let error):
                    print("Err!1: \(error)")
                }
            }
        }
    }
}

