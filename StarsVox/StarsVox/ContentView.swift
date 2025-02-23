import SwiftUI

struct ContentView: View {
    @State var inputText = ""
    @State private var isGenerating = false
    @State private var navigateToMakeLyrics = false
    @State private var isInputVisible = true
    
    var body: some View {
        VStack {
            if isInputVisible {
                ZStack(alignment: .topLeading) {
                    Rectangle()
                        .stroke(Color.black, lineWidth: 1)
                        .frame(width: 300, height: 300)
                    
                    TextEditor(text: $inputText)
                        .frame(width: 300, height: 300)
                    
                    if inputText.isEmpty {
                        Text("ここに文字を入力して下さい。\n例）冬　失恋")
                            .foregroundColor(.gray)
                            .padding(.top, 8)
                            .padding(.leading, 8)
                    }
                }
                
                Button {
                    // 生成中の状態にする
                    isGenerating = true
                    // 入力画面を非表示にする
                    isInputVisible = false
                    
                    // APIリクエストを送信
                    sendSUNOAPIRequest(prompt: inputText) { taskId in
                        DispatchQueue.main.async {
                            if let taskId = taskId {
                                print("Task ID: \(taskId)")
                                // 生成が完了したら次の画面に遷移
                                navigateToMakeLyrics = true
                            } else {
                                // エラー処理
                                print("Failed to get Task ID")
                                isInputVisible = true
                            }
                            isGenerating = false
                        }
                    }
                    
                } label: {
                    Text("生成する")
                }
            }
        }
        
        if isGenerating {
            MakeSound()
        }
        
        if navigateToMakeLyrics {
            MakeLyrics()
        }
    }
}

func sendSUNOAPIRequest(prompt: String, completion: @escaping (String?) -> Void) {
    // UUIDを生成
    let uuid = UUID().uuidString
    
    // リクエストURLを設定
    guard let url = URL(string: "https://apibox.erweima.ai/api/v1/generate") else {
        print("Invalid URL")
        completion(nil)
        return
    }
    
    // リクエストデータを作成
    let requestData: [String: Any] = [
        "prompt": prompt,
        "customMode": false,
        "instrumental": false,
        "model": "V3_5",
        "callBackUrl": "https://api.example.com/\(uuid)/callback"
    ]
    
    // リクエストの作成
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    request.addValue("Bearer a598074ca3130eaff8389734fb1dab72", forHTTPHeaderField: "Authorization")
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
    // JSONデータに変換
    do {
        let jsonData = try JSONSerialization.data(withJSONObject: requestData, options: [])
        request.httpBody = jsonData
    } catch {
        print("Error serializing JSON: \(error)")
        completion(nil)
        return
    }
    
    // URLSessionを使用してリクエストを送信
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            print("Error: \(error)")
            completion(nil)
            return
        }
        
        if let data = data {
            do {
                // レスポンスデータをJSONとして解析
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let dataDict = json["data"] as? [String: Any],
                   let taskId = dataDict["taskId"] as? String {
                    // taskIdを返す
                    completion(taskId)
                } else {
                    print("Invalid JSON structure")
                    completion(nil)
                }
            } catch {
                print("Error parsing JSON: \(error)")
                completion(nil)
            }
        } else {
            completion(nil)
        }
    }
    
    task.resume()
}
