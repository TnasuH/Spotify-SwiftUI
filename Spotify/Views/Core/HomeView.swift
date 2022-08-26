//
//  HomeView.swift
//  Spotify
//
//  Created by Tarik Nasuhoglu on 23.08.2022.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var vm = AlbumViewModel()
    
    var body: some View {
        NavigationView {
            bodyView
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: ProfileView()){
                            Image(systemName: "gear")
                        }
                    }
                }
                .navigationBarTitleDisplayMode(.large)
                .navigationBarHidden(false)
                .navigationTitle("Spotify")
        }
    }
    
    private var bodyView: some View {
        ScrollView
        {
            VStack{
                NewReleasedAlbumView(vm: vm)
                FeaturedPlaylistView(vm: vm)
                RecommendedView(vm: vm)
            }
        }
    }
    
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
