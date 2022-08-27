//
//  SearchTrackRowView.swift
//  Spotify
//
//  Created by Tarik Nasuhoglu on 27.08.2022.
//

import SwiftUI

struct SearchTrackRowView: View {
    
    @EnvironmentObject var pm: PlayerManagerViewModel
    
    var imgUrlStr: String = ""
    var title: String = ""
    var secondTitle: String = ""
    var subTitle: String = ""
    var imgCornerRadius: CGFloat = 45
    
    var track: Track?
    
    var body: some View {
         searchRowStyle1
            .onTapGesture {
                print("row clicked")
                guard let item = track else { return }
                withAnimation {
                    guard let _ = item.previewurl else {return}
                    if(item.album == nil) {
//                        item.album = self.album
                    }
                    pm.isPlaying = false
                    pm.currentTrack = item
                    pm.isPlaying = true
                    DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
                        pm.showLargePlayer = true
                    }
                }
            }
    }
    
    private var searchRowStyle1: some View {
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

struct SearchTrackRowView_Previews: PreviewProvider {
    static var previews: some View {
        SearchTrackRowView()
    }
}
