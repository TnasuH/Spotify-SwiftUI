//
//  PlayerView.swift
//  Spotify
//
//  Created by Tarik Nasuhoglu on 24.08.2022.
//

import SwiftUI

struct PlayerView: View {
    
    @State var playerIsFullScreen: Bool = false
    @State var playing: Bool = true
    @State var playerSeekTime: Double = 60
    var playerBgColors = Set<Color>()
    
    init() {
        playerBgColors.insert(Color.accentColor)
        playerBgColors.insert(Color.green)
        playerBgColors.insert(Color.black)
        playerBgColors.insert(Color.gray)
        playerBgColors.insert(Color.purple)
        playerBgColors.insert(Color.blue)
        playerBgColors.insert(Color.brown)
        playerBgColors.insert(Color.cyan)
        playerBgColors.insert(Color.indigo)
        playerBgColors.insert(Color.mint)
        playerBgColors.insert(Color.orange)
        playerBgColors.insert(Color.pink)
        playerBgColors.insert(Color.red)
        playerBgColors.insert(Color.teal)
        playerBgColors.insert(Color.yellow)
    }
    
    var body: some View {
        showMiniPlayer()
            .sheet(isPresented: $playerIsFullScreen) {
                showLargePlayer()
            }
    }
    
    private func showLargePlayer() -> some View {
        VStack (alignment: .center) {
            HStack{
                Button(action: {playerIsFullScreen.toggle()}){
                    Image(systemName: "chevron.down")
                }
                Spacer()
                Text("Album Name")
                Spacer()
                Image(systemName: "square.and.arrow.up")
            }
            .padding()
            .foregroundColor(.primary)
            Spacer()
            Image("albumCover")
                .resizable()
                .frame(width: Helper.screenWidth-100, height: Helper.screenWidth-100, alignment: .center)
                .scaledToFit()
            Spacer()
            HStack (alignment: .center) {
                VStack(alignment: .leading){
                    Text("Derdim Coktur Hangisine Yanayim")
                        .lineLimit(1)
                        .font(.system(.title3).weight(.heavy))
                    Text("Kubat")
                        .font(.system(.subheadline).weight(.regular))
                }
                Spacer()
                Image(systemName: "heart.fill")
                    .foregroundColor(.green)
            }
            .padding(.horizontal,20)
            Spacer()
            VStack{
                Slider(value: $playerSeekTime, in: 0...240)
                HStack{
                    Text("1:00")
                        .font(.caption)
                        .fontWeight(.semibold)
                    Spacer()
                    Text("-1:33")
                        .font(.caption)
                        .fontWeight(.semibold)
                }
            }
            .padding(.horizontal,20)
            Spacer()
            HStack(spacing:40){
                Button(action: {}){
                    Image(systemName: "shuffle")
                        .font(.system(size: 24, weight: .regular, design: .default))
                }
                Button(action: {}){
                    Image(systemName: "backward.end.fill")
                        .font(.system(size: 30, weight: .medium, design: .default))
                }
                Button(action: {playing.toggle()}){
                    Image(systemName: playing ? "pause.circle.fill" : "play.circle.fill")
                        .font(.system(size: 48, weight: .medium, design: .default))
                }
                Button(action: {}){
                    Image(systemName: "forward.end.fill")
                        .font(.system(size: 30, weight: .medium, design: .default))
                }
                Button(action: {}){
                    Image(systemName: "repeat")
                        .font(.system(size: 24, weight: .regular, design: .default))
                }
            }.foregroundColor(.primary)
                .padding(.vertical,10)
            Spacer()
        }
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
                }
                .padding(.vertical,10)
                .foregroundColor(.white)
                Spacer()
                Button(action: {
                    // TODO: player play pause flows
                    playing.toggle()
                }) {
                    Image(systemName: playing ? "pause.fill" : "play.fill") // TODO: play button icon will be change for the play status
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
        return playerBgColors.randomElement() ?? Color.green
    }
}

struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView()
            .previewLayout(.sizeThatFits)
    }
}
