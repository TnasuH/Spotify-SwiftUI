//
//  AlbumDetailsViewModel.swift
//  Spotify
//
//  Created by Tarik Nasuhoglu on 25.08.2022.
//

import SwiftUI

class AlbumDetailViewModel: ObservableObject {
    
    @Published var album: GetAlbums?
    @Published var durationms: Int = 0
    
    var albumId: String
    var apiCaller: APICaller = APICaller.shared
    
    init(albumId: String) {
        self.albumId = albumId
    }
    
    public func fetchData() {
        apiCaller.getAlbumDetail(for: self.albumId) {[weak self] result in
            switch result {
            case .success(let model):
                DispatchQueue.main.async {
                    self?.album = model
                    self?.durationms = (model.tracks.items.compactMap{ return $0.durationms }).reduce(0, +)
                }
            case .failure(let error):
                print("Err!1: \(error)")
            }
        }
        
    }
}
