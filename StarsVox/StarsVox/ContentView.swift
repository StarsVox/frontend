//
//  ContentView.swift
//  StarsVox
//
//  Created by 首藤沙良 on 2025/02/12.
//

import SwiftUI

struct ContentView: View {
    @State var inputText = ""
    @State private var isGenerating = false
    @State private var navigateToMakeLyrics = false
    // 入力画面を表示するかどうかを管理
    @State private var isInputVisible = true
    
    var body: some View {
            VStack {
                // ContentViewが表示されるかどうかを確認
                if isInputVisible {
                    
                    ZStack(alignment: .topLeading) {
                        Rectangle()
                            .stroke(Color.black, lineWidth: 1)
                            .frame(width: 300, height: 300)
                        
                        TextEditor(text: $inputText)
                            // TextEditorのサイズを指定
                            .frame(width: 300, height: 300)
                        
                        if inputText.isEmpty {
                            Text("ここに文字を入力して下さい。\n例）冬　失恋")
                                .foregroundColor(.gray)
                                .padding(.top, 8)
                                // TextがTextEditor内で隠れないように配置
                                .padding(.leading, 8)
                        }
                    }
                    
                    Button {
                        // 生成中の状態にする
                        isGenerating = true
                        // 入力画面を非表示にする
                        isInputVisible = false
                        
                        // 3秒後に生成中画面を終わらせ、MakeLyrics画面に遷移する
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            isGenerating = false
                            navigateToMakeLyrics = true
                        }
                        
                    } label: {
                        Text("生成する")
                    }
                        
                } // if isInputVisible　の終わり
            }  // VStack　縦の終わり
        
        // 「生成中」画面の表示
        if isGenerating {
            MakeSound()
        }
        
        // MakeLyrics画面に遷移
        if navigateToMakeLyrics {
            MakeLyrics()
        }
        
    }
}

#Preview {
    ContentView()
}
