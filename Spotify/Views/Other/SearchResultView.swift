//
//  SearchResultView.swift
//  Spotify
//
//  Created by Tarik Nasuhoglu on 24.08.2022.
//

import SwiftUI

struct SearchResultView: View {
    @Environment(\.isSearching) var isSearching
    @Environment(\.dismissSearch) var dismissSearch
    
    @ObservedObject var bindedVm: SearchViewModel
    
    @State var selectedEntityType: EntityType = .artist
    
    var apiCaller = APICaller.shared
    
    static let columnSize = Double((Helper.screenWidth / 2 ) - 5)
    
    let columns = [
        GridItem(.fixed(columnSize)),
        GridItem(.fixed(columnSize)),
    ]
    init(vm: SearchViewModel) {
        bindedVm = vm
        
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(displayP3Red: 0, green: 1, blue: 0, alpha: 0.6)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.green], for: .normal)
        
    }
    var body: some View {
        if isSearching == false {
            ScrollView(.vertical, showsIndicators: false) {
                
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach($bindedVm.categories, id: \.self.id) { $cat in
                        
                        NavigationLink(destination: CategoryPlaylistView(category: cat, vm: PlaylistViewModel(categoryPlaylistId: cat.id))) {
                            ZStack(alignment: .topLeading) {
                                Helper.getRandomColor()
                                
                                ZStack(alignment: .topLeading){
                                    
                                    ZStack{
                                        AsyncImage(url: URL(string:cat.icons.first?.url ?? "")){ image in
                                            image.resizable()
                                        } placeholder: {
                                            ProgressView()
                                        }
                                        .aspectRatio(contentMode: .fit)
                                        .cornerRadius(5)
                                        .rotationEffect(.degrees(22))
                                        .frame(width: 80, height: 80, alignment: .center)
                                        .padding(.top,25)
                                        .padding(.leading,(Helper.screenWidth / 2 ) - 60)
                                        //                                        .background(.yellow)
                                    }
                                    .frame(width: (Helper.screenWidth / 2 ) - 5, height: 100, alignment: .center)
                                    
                                    ZStack(alignment: .topLeading){
                                        Text(cat.name)
                                            .multilineTextAlignment(.leading)
                                            .font(.title3.weight(.bold))
                                            .padding(.top,10)
                                            .padding(.leading,10)
                                    }
                                    .frame(width: (Helper.screenWidth / 2 ) - 5, height: 100, alignment: .topLeading)
                                }
                            }.foregroundColor(.white).frame(height: 90, alignment: .center)
                                .cornerRadius(5)
                        }
                    }
                }
            }
        }
        
        if  isSearching {
            Picker("Select the media", selection: $selectedEntityType) {
                ForEach(EntityType.allCases) { type in
                    Text(type.Title())
                        .tag(type)
                }
            }
            .onChange(of: selectedEntityType, perform: { newValue in
                bindedVm.clear()
            })
            .pickerStyle(.segmented)
            .padding(.horizontal)
            Divider()
            
            switch selectedEntityType {
            case .artist:
                List {
                    ForEach(bindedVm.artists, id: \.id) { artist in
                        
                        NavigationLink(destination: ArtistView(vm: ArtistViewModel(artist: artist))) {
                            searchRowStyle1(imgUrlStr: artist.images?.first?.url ?? "", title: artist.name, secondTitle: "\(artist.followers?.total ?? 0) Followers")
                        }
                    }
                    if bindedVm.artists.count == 0 {
                        searchSomeThing
                    }
                    ListPlaceholderRowView(state: bindedVm.state, loadMore: {
                        bindedVm.loadMore(type: EntityType.artist.id)
                    })
                }
                .padding(0)
            case .album:
                List {
                    ForEach(bindedVm.albums, id: \.id) { album in
                        searchRowStyle1(imgUrlStr: album.images.first?.url ?? "", title: album.name, secondTitle: album.artists.first?.name ?? "",subTitle: "\(album.totalTracks) Tracks")
                    }
                    if bindedVm.albums.count == 0 {
                        searchSomeThing
                    }
                    ListPlaceholderRowView(state: bindedVm.state, loadMore: { bindedVm.loadMore(type: EntityType.album.id)})
                }
            case .track:
                List {
                    ForEach(bindedVm.tracks, id: \.id) { track in
                        searchRowStyle1(imgUrlStr: track.album?.images.first?.url ?? "", title: track.name, secondTitle: "\(track.album?.name ?? "") - \(track.artists?.first?.name ?? "")", imgCornerRadius: 4)
                    }
                    if bindedVm.tracks.count == 0 {
                        searchSomeThing
                    }
                    ListPlaceholderRowView(state: bindedVm.state, loadMore: { bindedVm.loadMore(type: EntityType.track.id)})
                }
            case .playlist:
                List {
                    ForEach(bindedVm.playlists, id: \.id) { playlist in
                        searchRowStyle1(imgUrlStr: playlist.images.first?.url ?? "", title: playlist.name, secondTitle: "By \(playlist.owner.displayName ?? "")", subTitle: "\(playlist.tracks.total) Tracks", imgCornerRadius: 4)
                    }
                    if bindedVm.playlists.count == 0 {
                        searchSomeThing
                    }
                    ListPlaceholderRowView(state: bindedVm.state, loadMore: { bindedVm.loadMore(type: EntityType.playlist.id)})
                }
            }
        }
    }
    
    private var searchSomeThing: some View {
        Text("Search something")
    }
    
    private func searchRowStyle1(imgUrlStr: String = "", title: String = "", secondTitle: String = "", subTitle: String = "", imgCornerRadius: CGFloat = 45) -> some View {
        HStack (alignment: .center){
            AsyncImage(url: URL(string: imgUrlStr)){ image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 45, height: 45, alignment: .center)
            .aspectRatio(contentMode: .fit)
            .cornerRadius(imgCornerRadius)
            VStack (alignment: .leading){
                Text(title)
                    .lineLimit(1)
                    .font(.system(size: 18, weight: .medium))
                Text(secondTitle)
                    .font(.subheadline)
                if subTitle != "" {
                    Text(subTitle)
                        .font(.footnote)
                }
                
            }
        }
    }
}

struct SearchResultView_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultView(vm: SearchViewModel())
    }
}
