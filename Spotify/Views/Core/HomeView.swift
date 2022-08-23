//
//  HomeView.swift
//  Spotify
//
//  Created by Tarik Nasuhoglu on 23.08.2022.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var vm = AlbumViewModel()
    
    var body: some View {
        NavigationView {
            bodyView
                .navigationBarTitleDisplayMode(.large)
                .navigationBarHidden(false)
                .navigationTitle("Home")
        }
    }
    
    private var bodyView: some View {
        ScrollView
        {
            VStack{
                NewReleasedAlbumView(newAlbumList: $vm.newReleases)
                FeaturedPlaylistView(featuredPlaylist: $vm.featuredPlaylist)
                RecommendedView(recommendedTracks: $vm.recommendations)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
