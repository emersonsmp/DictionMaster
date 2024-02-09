//
//  BaseStateView.swift
//  DictionMaster
//
//  Created by Emerson Sampaio on 08/02/24.
//

import SwiftUI

struct BaseStateView<VM, SuccessView, ErrorView, LoadingView>: View
where VM: ViewModel, SuccessView: View, ErrorView: View, LoadingView: View {
    
    @ObservedObject var viewModel: VM
    let successView: () -> SuccessView
    let errorView: (String) -> ErrorView
    let loadingView: () -> LoadingView
    
    init(viewModel: VM,
         @ViewBuilder successView: @escaping () -> SuccessView,
         @ViewBuilder errorView: @escaping (String) -> ErrorView = {MessageView(message: $0)},
         @ViewBuilder loadingView: @escaping () -> LoadingView = { ProgressView() }) {
        
        self.viewModel = viewModel
        self.successView = successView
        self.errorView = errorView
        self.loadingView = loadingView
    }
    
    var body: some View {
        ZStack {
            successView()
            switch viewModel.state {
                case .initial,.loading:
                    loadingView()
                case .success:
                    EmptyView()
                case .error(let message):
                    errorView(message)
                default:
                    EmptyView()
            }
        }
    }
}

struct MessageView: View {
    let message: String

    var body: some View {
        VStack {
            Spacer()
            Text(message)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.gray)
            Spacer()
        }
    }
}
