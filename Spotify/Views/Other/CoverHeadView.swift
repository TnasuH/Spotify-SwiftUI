//
//  CoverHeadView.swift
//  Spotify
//
//  Created by Tarik Nasuhoglu on 25.08.2022.
//

import SwiftUI

struct CoverHeadView: View {
    
    var album: Album
    var duration: Int?
    
    var durationToString: String {
        get {
            guard let duration = duration else {
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
    
    
    var body: some View {
        VStack{
            AsyncImage(url: URL(string: album.images.first?.url ?? "")) { image in
                image.resizable()
                
            } placeholder: {
                ProgressView()
            }
            .aspectRatio(contentMode: .fill)
            .frame(width: Helper.screenWidth*0.7, height: Helper.screenWidth*0.7, alignment: .center)
            .cornerRadius(0)
            .padding(.bottom,10)
            
            HStack (alignment: .top ){
                VStack(alignment: .leading, spacing:5){
                    Text(album.name)
                        .font(.headline)
                    Text(Helper.getArtistsName(artists: album.artists))
                        .font(.subheadline)
                    HStack{
                        VStack(alignment: .leading){
                            Text(durationToString)
                                .font(.footnote)
                            HStack (spacing:20){
                                Image(systemName: "heart")
                                Image(systemName: "arrow.down.circle")
                                Image(systemName: "ellipsis")
                                
                            }.font(.title2)
                            
                        }
                        Spacer()
                        ZStack{
                            Image(systemName: "play.circle.fill")
                                .font(.system(size:38))
                                .foregroundColor(.green)
                            Image(systemName: "shuffle.circle.fill")
                                .font(.subheadline)
                                .symbolRenderingMode(.palette)
                                .foregroundStyle(.green, Color(uiColor: .darkGray))
                                .padding(.top,30)
                                .padding(.leading,23)
                        }
                        .padding(.trailing,5)
                    }
                }
                .padding(.leading,10)
            }
        }
    }
}

struct CoverHeadView_Previews: PreviewProvider {
    static var previews: some View {
        CoverHeadView(album: Album(albumType: "", artists: [], availableMarkets: [], externalUrls: ExternalUrls(spotify: ""), href: "", id: "", images: [], name: "", releaseDate: "", releaseDatePrecision: "", totalTracks: 3, type: nil, uri: "", tracks: nil))
    }
}
