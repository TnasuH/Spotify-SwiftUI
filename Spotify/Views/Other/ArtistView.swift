//
//  ArtistView.swift
//  Spotify
//
//  Created by Tarik Nasuhoglu on 27.08.2022.
//

import SwiftUI

struct ArtistView: View {
    
    @StateObject var vm: ArtistViewModel
    var gradient: LinearGradient = LinearGradient(colors: [Helper.getRandomColor(), Helper.getRandomColor()],
                                                  startPoint: .top, endPoint: .bottom)
    
    static let columnSize = Double((Helper.screenWidth - 80) / 2.5)
    
    let rows = [
        GridItem(.fixed(columnSize)),
        GridItem(.fixed(columnSize)),
        GridItem(.fixed(columnSize))
       ]
    
    var body: some View {
        ZStack(alignment: .top) {
            gradient.ignoresSafeArea()
            Color.black.ignoresSafeArea().opacity(0.5)
            ScrollView {
                VStack(alignment: .center){
                    AsyncImage(url: URL(string: vm.artist.images?.first?.url ?? "")) { image in
                        image.resizable()
                        
                    } placeholder: {
                        ProgressView()
                    }
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 160, alignment: .center)
                    .cornerRadius(5)
                    .padding(.top,20)
                    HStack(alignment: .center, spacing: 60){
                        VStack (alignment: .center){
                            Text("\(vm.artist.followers?.total ?? -99)\nfollowers")
                                .font(.headline).fontWeight(.medium)
                                .multilineTextAlignment(.center)
                            Text(vm.artist.genres?.joined(separator: ", ") ?? "")
                                .font(.footnote).fontWeight(.light)
                                .lineLimit(1)
                                .frame(maxWidth: 120)
                        }
                        VStack(alignment: .center){
                            Text("Popularity")
                                .font(.subheadline)
                                .fontWeight(.ultraLight)
                                .padding(.bottom, 5)
                            HStack {
                                Image(systemName: vm.artist.popularity ?? 0 > 0 ? "flame.fill" : "flame")
                                Image(systemName: vm.artist.popularity ?? 0 > 20 ? "flame.fill" : "flame") //20
                                Image(systemName: vm.artist.popularity ?? 0 > 40 ? "flame.fill" : "flame") //40
                                Image(systemName: vm.artist.popularity ?? 0 > 60 ? "flame.fill" : "flame") //60
                                Image(systemName: vm.artist.popularity ?? 0 > 80 ? "flame.fill" : "flame") //80-100
                            }
                        }
                    }
                    .padding(.top, 20)
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHGrid(rows: rows) {
                            ForEach(vm.albums?.items ?? [], id: \.self.id) { album in
                                NavigationLink(destination: AlbumView(album: album)) {
                                    newReleasedAlbumCell(album: album)
                                }
                            }
//                            ListPlaceholderRowView(state: vm.newReleasesState, loadMore: {
//                                vm.loadMoreNewReleases()
//                            })
                        }
                    }
                    
                }.onAppear {
                    vm.getArtistAlbum()
                }
                
                Spacer()
            }
        }
        .onAppear(perform: {
            print("rendered")
        })
        .navigationTitle(vm.artist.name)
        
            
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
                    .foregroundColor(.primary)
            }
            .frame(width: Helper.screenWidth - 80, alignment: .leading)
        }
        .frame(height: (Helper.screenWidth - 80)/2.5, alignment: .center)
    }
}

struct ArtistView_Previews: PreviewProvider {
    static var previews: some View {
        ArtistView(vm: ArtistViewModel(artist: Artist(externalUrls: ExternalUrls(spotify: ""), followers: Followers(href: "", total: 3), genres: [], href: "", id: "", images: [], name: "", popularity: 3, type: "", uri: "")))
    }
}
