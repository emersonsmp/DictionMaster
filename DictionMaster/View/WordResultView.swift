//
//  WordResult.swift
//  DictionMaster
//
//  Created by Emerson Sampaio on 05/02/24.
//

import Foundation
import SwiftUI
import AVFoundation

struct WordResultView: View {
    @State var word: String
    @StateObject var viewModel = WordResultViewModel()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var player: AVPlayer?
    
    var body: some View {
        VStack{
            BaseStateView(viewModel: viewModel) {
                content
            }
        }
    }
    
    var content: some View {
        ScrollView{
            if let response = viewModel.response {
                VStack(alignment: .leading, spacing: 16){
                    Text(response.word.capitalizedFirstLetter)
                        .font(.system(size: 45.0, weight: .bold, design: .rounded))
                        .padding(.top, 16)
                    
                    HStack{
                        Button(action: {
                            if let audioURL = response.phonetics.first?.audio,
                               let url = URL(string: audioURL) {
                                player = AVPlayer(url: url)
                                player?.play()
                            }
                        }) {
                            ZStack {
                                Circle()
                                    .frame(width: 46, height: 46)
                                    .foregroundColor(.dictionaryBlue)
                                
                                Image(uiImage: UIImage(named: "audio-speaker-on")!)
                                    .scaledToFill()
                                    .frame(width: 22, height: 22)
                            }
                        }
                        
                        Text(response.phonetic ?? "")
                            .font(.system(size: 22, weight: .bold, design: .rounded))
                            .padding(.top, 16)
                            .padding(.bottom, 16)
                            .foregroundColor(.dictionarygray)
                            .opacity(0.5)
                        
                    }
                    
                    VStack(alignment: .leading, spacing: 20){
                        ForEach(Array(viewModel.definitions.enumerated()), id: \.element.id) { index, item in
                            VStack(alignment: .leading, spacing: 4) {
                                Text("\(index + 1)) \(item.definition)")
                                    .bold()
                                    .font(.system(size: 16, weight: .bold, design: .rounded))
                                    .padding(.bottom, 5)
                                
                                if let example = item.example, !example.isEmpty {
                                    Text("• \(example)")
                                        .font(.system(size: 16, weight: .regular, design: .rounded))
                                        .padding(.bottom, 24)
                                }
                                
                            }
                        }
                    }
                    .padding(.trailing, 42)
                    
                    Divider()
                        .frame(height: 10)
                    
                    Text("That’s it for \"\(response.word)\"!")
                        .font(.system(size: 24.0, weight: .bold, design: .rounded))
                    
                    Text("Try another search now!")
                        .font(.system(size: 16.0, weight: .regular, design: .rounded))
                    
                    
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("NEW SEARCH")
                            .font(.system(size: 18.0, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 64)
                            .background(.dictionaryBlue)
                            .cornerRadius(12)
                    }
                    
                    Spacer()
                }
                .padding(.leading, 16)
                .padding(.trailing, 16)
            }
        }
        .onAppear(perform: {
            viewModel.fetchItems(word: word)
        })
        .onDisappear {
            viewModel.response = nil
            viewModel.definitions = []
        }
    }
}

#Preview {
    WordResultView(word: "word")
}


extension String {
    var capitalizedFirstLetter: String {
        guard let firstCharacter = self.first else { return self }
        return String(firstCharacter).uppercased() + dropFirst()
    }
}
