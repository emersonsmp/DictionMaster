//
//  ContentView.swift
//  DictionMaster
//
//  Created by Emerson Sampaio on 04/02/24.
//

import SwiftUI
import AVFoundation


struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
    @State private var isPremiumSheetPresented = false
    
    var body: some View {
        NavigationView{
            VStack{
                LanguageSelector()
                
                Spacer()
                
                TextField("Digite aqui...", text: $viewModel.word)
                    .foregroundColor(.black)
                    .font(Font.custom("SFProRounded-Regular", size: 32))
                    .multilineTextAlignment(.center)
                    .frame(width: 200, height: 50)
                
                Spacer()
                
                SearchButton(action: {
                    if viewModel.canPerformSearch() {
                        viewModel.goToSearch()
                            viewModel.incrementSearchCount()
                    } else {
                        isPremiumSheetPresented = true
                    }
                })
                .sheet(isPresented: $isPremiumSheetPresented) {
                    LimitExceededView()
                }
                
                NavigationLink(
                    destination: WordResultView(word: viewModel.word),
                    isActive: $viewModel.isNavigationActive,
                    label: {
                        EmptyView()
                    }).isDetailLink(false)
            }
            .onAppear{
                viewModel.word = ""
                
                if UserDefaults.standard.object(forKey: Constants.lastSearchDateKey) == nil {
                    UserDefaults.standard.set(Date(), forKey: Constants.lastSearchDateKey)
                }
            }
            .padding(.leading, 16)
            .padding(.trailing, 16)
        }
    }
}

#Preview {
    ContentView()
}

struct LanguageSelector: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .frame(width: 137, height: 40)
                .foregroundColor(.dictionaryGray100)
            
            HStack {
                Image(uiImage: UIImage(named: "english")!)
                    .scaledToFill()
                    .frame(width: 27, height: 27)
                
                Text("ENGLISH")
                    .font(Font.custom("SFProRounded-Regular", size: 18))
            }
        }
        .padding(.top, 20)
    }
}

struct SearchButton: View {
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text("SEARCH")
                .font(.system(size: 18.0, weight: .bold, design: .rounded))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 64)
                .background(.dictionaryBlue)
                .cornerRadius(12)
        }
    }
}


