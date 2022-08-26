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
    
    public func clear() {
        
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
                        //print(model)
                        self?.detail = model
                        print("asdasd")
                        print(model.tracks.items.count)
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
