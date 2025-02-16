//
//  MakeLyrics.swift
//  StarsVox
//
//  Created by 首藤沙良 on 2025/02/13.
//

import SwiftUI

struct MakeLyrics: View {
    @State private var navigateToCompletedMusic = false
    @State private var isMakeLyricsView = true
    
    var body: some View {
        VStack {
    
            if isMakeLyricsView {
                
                Rectangle()
                    .stroke(Color.black, lineWidth: 1)
                    .frame(width: 300, height: 300)
                    .overlay(
                        // 歌詞が入る部分をScrollViewで囲む
                        ScrollView(.vertical) {
                            VStack {
                                // スクロールできる
                                Text("""
                                    これはサンプルの歌詞です。
                                    ここに歌詞がどんどん続きます。
                                    次の行の歌詞もどんどん追加されます。
                                    長い歌詞はスクロールすることで見ることができます。
                                    ここまで続けていくと長い歌詞が見えるようになります。
                                    """)
                                .frame(width: 280)
                                .padding(10)
                            }
                        }
                    )
                    
                
                HStack {
                    Button {
                        
                    } label: {
                        Image(systemName: "play.circle")
                    }

                    Button {
                        
                    } label: {
                        Image(systemName: "pause.circle")
                    }
                }
                .imageScale(.large)
                
                
               
                
                
                HStack {
                    
                    Button {
                        
                        isMakeLyricsView = false
                        
                        // 「録音1」ボタンが押されたら遷移
                        navigateToCompletedMusic = true
                    } label: {
                        Text("録音1")
                    }

                    Button {
                        
                        isMakeLyricsView = false
                        
                        // 「録音2」ボタンが押されたら遷移
                        navigateToCompletedMusic = true
                    } label: {
                        Text("録音2")
                    }
                }
                
                
                
                
               
                
                
                Button {
                    
                } label: {
                    Image(systemName: "music.microphone")
                        .imageScale(.large)
                }
            }
            
        } // VStack　縦の終わり
        
        
        // 遷移先の画面を表示する
        if navigateToCompletedMusic {
            CompletedMusic()
        }
        
    }
}

#Preview {
    MakeLyrics()
}
