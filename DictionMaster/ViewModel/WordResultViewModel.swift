//
//  HomeViewModel.swift
//  DictionMaster
//
//  Created by Emerson Sampaio on 04/02/24.
//

import Foundation
import Alamofire

class WordResultViewModel: ViewModel {
    private lazy var service = Service()
    
    @Published var response: Response?
    @Published var definitions: [Definition] = []
    @Published var word: String = ""
    
    func fetchItems(word: String) {
        service.fetchWordMeaning(word: word) { result in
            switch result {
                case .success(let response):
                    self.response = response
                    if let definitions = response.meanings.first?.definitions {
                        self.definitions = definitions
                    }

                    DispatchQueue.main.async {
                        self.state = .success
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    self.state = .error(error.localizedDescription)
            }
        }
    }
}

