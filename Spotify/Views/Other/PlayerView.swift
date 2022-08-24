//
//  PlayerView.swift
//  Spotify
//
//  Created by Tarik Nasuhoglu on 24.08.2022.
//

import SwiftUI

struct PlayerView: View {
    
    @State var playerIsFullScreen: Bool = false
    
    var playerBackgroundColors = Set<Color>()
    
    init() {
        playerBackgroundColors.insert(Color.accentColor)
        playerBackgroundColors.insert(Color.green)
        playerBackgroundColors.insert(Color.black)
        playerBackgroundColors.insert(Color.gray)
        playerBackgroundColors.insert(Color.purple)
        playerBackgroundColors.insert(Color.blue)
        playerBackgroundColors.insert(Color.brown)
        playerBackgroundColors.insert(Color.cyan)
        playerBackgroundColors.insert(Color.indigo)
        playerBackgroundColors.insert(Color.mint)
        playerBackgroundColors.insert(Color.orange)
        playerBackgroundColors.insert(Color.pink)
        playerBackgroundColors.insert(Color.red)
        playerBackgroundColors.insert(Color.teal)
        playerBackgroundColors.insert(Color.yellow)
    }
    
    var body: some View {
        showMiniPlayer()
            .sheet(isPresented: $playerIsFullScreen) {
                showLargePlayer()
            }
    }
    
    private func showLargePlayer() -> some View {
        Text("Large Player will be in here")
    }
    
    private func showMiniPlayer() -> some View {
        let trackImageUrlString = "" //track.album?.images.first?.url ?? ""
        
        return ZStack{
            changeBackground()
                .cornerRadius(5)
            Color.black.opacity(0.8)
                .cornerRadius(5)
            HStack(alignment: .center) {
                Image("albumCover")
                    .resizable()
                    .scaledToFill()
                    .frame(width: Helper.screenWidth/6, height: Helper.screenWidth/6, alignment: .center)
                    .cornerRadius(5)
                    .padding(.horizontal,5)
                // TODO: When player running from the data, u should change Image to AsyncImage or SDWebImage for cache.. its not decided yet..
                //                AsyncImage(url: URL(string: trackImageUrlString)) { image in
                //                    image.resizable()
                //                } placeholder: {
                //                    ProgressView()
                //                }
                //                .aspectRatio(contentMode: .fit)
                //                .cornerRadius(5)
                //                .frame(width: Helper.screenWidth/5.3)
                //                .padding(.top,10)
                VStack(alignment: .leading, spacing: 7) {
                    Text("Daglar Daglar")
                        .font(.title3)
                        .bold()
                    Text("Baris Manco")
                        .font(.subheadline)
                }.padding(.vertical,10)
                Spacer()
                Button(action: {
                    // TODO: player play pause flows
                    print("play button toggle runned")
                }) {
                    Image(systemName: playerIsFullScreen ? "play.fill" : "pause.fill") // TODO: play button icon will be change for the play status
                        .font(.title)
                        .foregroundColor(.white)
                }
                .padding(.horizontal,20)
            }
            .padding(.horizontal, 2)
        }
        .padding(.horizontal,5)
        .frame(height: 80, alignment: .center)
        .onTapGesture {
            playerIsFullScreen.toggle()
        }
        .padding(.bottom,50)
    }
    
    private func changeBackground() -> Color {
        return playerBackgroundColors.randomElement() ?? Color.green
    }
}

struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView()
            .previewLayout(.sizeThatFits)
    }
}
