//
//  SearchView.swift
//  Spotify
//
//  Created by Tarik Nasuhoglu on 24.08.2022.
//

import SwiftUI
enum EntityType: String, Identifiable, CaseIterable {
    case artist
    case album
    case track
    case playlist
    
    var id: String {
        self.rawValue
    }
    
    func Title() -> String {
        switch self {
        case .artist:
            return "Artist"
        case .album:
            return "Albums"
        case .track:
            return "Track"
        case .playlist:
            return "Playlist"
        }
    }
}
struct SearchView: View {
    
    @StateObject private var vm: SearchViewModel = SearchViewModel()
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                SearchResultView(vm: vm).navigationTitle("Search")
            }
        }
        .searchable(text: $vm.searchTerm)
    }
}


struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}

