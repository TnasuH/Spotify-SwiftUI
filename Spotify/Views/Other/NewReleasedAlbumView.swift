//
//  NewReleasedAlbumView.swift
//  Spotify
//
//  Created by Tarik Nasuhoglu on 23.08.2022.
//

import SwiftUI

struct NewReleasedAlbumView: View {
    
    @ObservedObject var vm: AlbumViewModel
    
    static let columnSize = Double((Helper.screenWidth - 80) / 2.5)
    
    let rows = [
        GridItem(.fixed(columnSize)),
        GridItem(.fixed(columnSize)),
        GridItem(.fixed(columnSize))
       ]
    
    var body: some View {
        VStack(alignment: .leading){
            newReleasedAlbumTitle
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: rows) {
                    ForEach(vm.newReleasesAlbum.items, id: \.self.id) { album in
                        NavigationLink(destination: AlbumView(album: album)) {
                            newReleasedAlbumCell(album: album)
                        }
                    }
                    ListPlaceholderRowView(state: vm.newReleasesState, loadMore: {
                        vm.loadMoreNewReleases()
                    })
                }
            }
        }
    }
    
    private var newReleasedAlbumTitle: some View {
        Text("New Released Albums")
            .font(.title)
            .bold()
            .padding(.top,5)
            .padding(.horizontal)
    }
    
    private func newReleasedAlbumCell(album: Album) -> some View {
        let albumImageUrlString = album.images.first?.url ?? ""
        return ZStack{
            Color.gray.opacity(0.2)
            HStack(alignment: .top) {
                AsyncImage(url: URL(string: albumImageUrlString)) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .aspectRatio(contentMode: .fit)
                .frame(width: Helper.screenWidth/3)
                VStack(alignment: .leading, spacing: 7){
                    Text(album.name)
                        .font(.title2)
                        .bold()
                    Text(album.artists.first?.name ?? "-")
                        .font(.title3)
                    Spacer()
                    Text("Tracks: \(album.totalTracks)")
                        .font(.subheadline)
                }.padding(.vertical,10)
            }
            .frame(width: Helper.screenWidth - 80, alignment: .leading)
        }
        .frame(height: (Helper.screenWidth - 80)/2.5, alignment: .center)
        .foregroundColor(.primary)
    }
    
}

struct NewReleasedAlbumView_Previews: PreviewProvider {
    static var previews: some View {
        NewReleasedAlbumView(vm: AlbumViewModel())
            .previewLayout(.sizeThatFits)
    }
}
