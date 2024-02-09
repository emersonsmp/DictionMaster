//
//  ViewModel.swift
//  DictionMaster
//
//  Created by Emerson Sampaio on 08/02/24.
//

import Foundation

@MainActor
class ViewModel: ObservableObject {
    @Published var state: ViewState = .initial
}

enum ViewState: Equatable {
    case initial, loading, success, empty, error(String)
}
