//
//  FeaturedPlaylistView.swift
//  Spotify
//
//  Created by Tarik Nasuhoglu on 24.08.2022.
//

import SwiftUI

struct FeaturedPlaylistView: View {
    
//    @Binding var featuredPlaylist: [PlaylistsItem]

    @ObservedObject var vm: AlbumViewModel
    
    static let columnSize = Double((Helper.screenWidth)/2)
    
    let rows = [
        GridItem(.fixed(columnSize)),
        GridItem(.fixed(columnSize))
       ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            featuredPlaylistTitle
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: rows, spacing: 40) {
                    ForEach(vm.featuredPlaylist.playlists.items, id:\.id) { plistitem in
                        NavigationLink(destination: {
                            PlaylistView(playlist: plistitem)
                        }, label: {
                            featuredPlaylistCell(plistItem: plistitem)
                        })
                    }
                    ListPlaceholderRowView(state: vm.featuredPlaylistState, loadMore: {
                        vm.loadMoreFeaturedPlaylists()
                    })
                }
            }.foregroundColor(.primary)
        }
    }
    
    private var featuredPlaylistTitle: some View {
        Text("Featured Playlist")
            .font(.title)
            .bold()
            .padding(.top,5)
            .padding(.horizontal)
    }
    
    private func featuredPlaylistCell(plistItem: PlaylistsItem) -> some View {
        
        let playlistImageUrlString = plistItem.images.first?.url ?? ""
        return ZStack{
            VStack(alignment: .center, spacing: 0) {
                AsyncImage(url: URL(string: playlistImageUrlString)) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .aspectRatio(contentMode: .fit)
                .cornerRadius(5)
                .frame(width: Helper.screenWidth/3)
                
                VStack(alignment: .center, spacing: 0){
                    Text("\(plistItem.name)")
                        .font(.title3)
                        .bold()
                    Text(plistItem.owner.name ?? "")
                        .font(.subheadline)
                }
                .padding(.top,5)
            }
            .frame(height: Helper.screenWidth/2.2, alignment: .leading)
        }
    }
}

struct FeaturedPlaylistView_Previews: PreviewProvider {
    static var previews: some View {
        FeaturedPlaylistView(vm: AlbumViewModel())
            .previewLayout(.sizeThatFits)
    }
}
