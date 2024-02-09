//
//  LimitExceededView.swift
//  DictionMaster
//
//  Created by Emerson Sampaio on 08/02/24.
//

import Foundation
import SwiftUI

struct LimitExceededView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack(spacing: 0){
            Image("background-image")
                .resizable()
                .scaledToFill()
                .padding(.top, -20)
            
            Image("icon")
                .frame(width: 78, height: 78)
                .padding(.top, -39)
                .padding(.bottom, 16)
            
            Image("title")
                .frame(width: 180, height: 32)
                .padding(.trailing, -32)
                .padding(.bottom, 26)
            
            VStack(spacing: 0){
                VStack{
                    Text("Subscribe now to get").bold()
                    + Text(" unlimited ")
                        .bold()
                        .foregroundColor(.dictionaryBlue)
                    + Text("searches and full access to").bold()
                    + Text(" all features").bold()
                        .foregroundColor(.dictionaryBlue)
                }
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .multilineTextAlignment(.center)
                .padding(.bottom, 26)
                
                VStack{
                    Text("Try 7 Days Free").bold()
                    + Text(", then only ")
                    + Text("$19,99").bold()
                    + Text(" per year. Cancel anytime. Cancel anytime")
                }
                .font(.system(size: 16, weight: .bold, design: .rounded))
                .multilineTextAlignment(.center)
                .padding(.bottom, 16)
                

                
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("SUBSCRIBE")
                        .font(.system(size: 18.0, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 64)
                        .background(Color(.dictionaryBlue))
                        .cornerRadius(12)
                        .padding(.bottom, 36)
                }
            }
            .padding(.leading, 16)
            .padding(.trailing, 16)
        }
        .ignoresSafeArea()
    }
}


#Preview {
    LimitExceededView()
}
