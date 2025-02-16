//
//  CompletedMusic.swift
//  StarsVox
//
//  Created by 首藤沙良 on 2025/02/14.
//

import SwiftUI

struct CompletedMusic: View {
        
    var body: some View {
        VStack {
            
            
            ZStack{
                //Image(systemName: "")
                Rectangle()
                    .stroke(Color.black, lineWidth: 1)
                    .frame(width: 300, height: 300)
                Text("写真を入れる")
            }
            
            
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
            
            
        } // Vstack の終わり
        
        
    }
    
    
}

#Preview {
    CompletedMusic()
}
