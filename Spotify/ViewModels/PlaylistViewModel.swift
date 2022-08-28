//
//  PlaylistViewModel.swift
//  Spotify
//
//  Created by Tarik Nasuhoglu on 25.08.2022.
//

import SwiftUI

class PlaylistViewModel: ObservableObject {
    
    @Published var Id: String?
    @Published var detail: GetPlaylists?
    @Published var time: String = ""
    @Published var playlistState: FetchState = .good
    @Published var durationms: Int?
    
    
    @Published var currentUserPlaylist: Playlists?
    
    //CategoryPlaylist
    @Published var categoryPlaylists: Playlists?
    var categoryPlaylistId: String?
    
    init(categoryPlaylistId: String) {
        self.categoryPlaylistId = categoryPlaylistId
    }
    
    var durationToString: String {
        get {
            guard let duration = durationms else {
                return ""
            }
            //let seconds = (duration / 1000) % 60 ;
            let minutes = ((duration / (1000*60)) % 60);
            let hours = ((duration / (1000*60*60)) % 24);
            
            if hours != 0 {
                return "\(hours)h \(minutes)m"
            } else if minutes != 0 {
                return "\(minutes)m"
            }
            return ""
        }
    }
    
    var apiCaller: APICaller = APICaller.shared
    
    init() {
        
    }
    
    public func getLoginUserPlaylist() {
        guard playlistState == .good else { return }
        
        self.playlistState = .isLoading
        apiCaller.getCurrentUserPlaylists(limit:20, offset: 0) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    self?.currentUserPlaylist = model
                    let resultTotal = model.items.count
                    self?.playlistState = (resultTotal < (model.total )) ? .good : .loadedAll
                case .failure(let err):
                    self?.playlistState = .error(err.localizedDescription)
                }
            }
        }
    }
    
    public func loadMoreLoginUserPlaylist() {
        guard playlistState == .good else { return }
        
        self.playlistState = .isLoading
        
        apiCaller.getCurrentUserPlaylists(limit: 20, offset: self.currentUserPlaylist?.items.count ?? 0) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    
                    self?.currentUserPlaylist?.items.append(contentsOf: model.items)
                    let resultTotal = self?.currentUserPlaylist?.items.count ?? 0
                    self?.playlistState = (resultTotal < (model.total )) ? .good : .loadedAll
                case .failure(let err):
                    self?.playlistState = .error(err.localizedDescription)
                }
            }
        }
    }
    
    public func getCategoryPlaylist() {
        guard playlistState == .good else { return }
        
        self.playlistState = .isLoading
        
        apiCaller.getCategoryPlaylist(categoryId: self.categoryPlaylistId!, offset: 0, limit: 20) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    self?.categoryPlaylists = model
                    self?.playlistState = .good
                    
                case .failure(let error):
                    self?.playlistState = .error(error.localizedDescription)
                }
            }
        }
    }
    
    public func getCategoryPlaylistMore() {
        guard playlistState == .good else { return }
        self.playlistState = .isLoading
        
        apiCaller.getCategoryPlaylist(categoryId: self.categoryPlaylistId!, offset: self.categoryPlaylists?.items.count ?? 0, limit: self.categoryPlaylists?.limit ?? 20) {
            [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let result):
                    
                    self?.categoryPlaylists?.items.append(contentsOf: result.items)
                    let resultTotal = self?.categoryPlaylists?.items.count ?? 0
                    self?.playlistState = (resultTotal < (result.total )) ? .good : .loadedAll
                    
                case .failure(let err):
                    self?.playlistState = .error(err.localizedDescription)
                }
            }
        }
    }
    
    public func getPlaylist(id: String = "37i9dQZF1DXaE9T4Nls8eC") {
        guard playlistState == FetchState.good else {
            return
        }
        self.playlistState = .isLoading
        
            apiCaller.getPlaylists(for: id) {[weak self] result in
                switch result {
                case .success(let model):
                    DispatchQueue.main.async {
                        self?.detail = model
                        self?.durationms = (model.tracks.items.compactMap{ return $0.track.durationms
                        }).reduce(0, +)
                        self?.playlistState = .loadedAll
                    }
                case .failure(let error):
                    print("Err!1: \(error)")
                }
            
        }
    }
}
