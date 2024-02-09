//
//  Service.swift
//  DictionMaster
//
//  Created by Emerson Sampaio on 07/02/24.
//

import Foundation
import Alamofire

class Service{
    let baseUrl = "https://api.dictionaryapi.dev/api/v2/entries/en/"
    let sessionManager: Session
    
    init() {
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .useProtocolCachePolicy
        self.sessionManager = Session(configuration: configuration)
    }
    
    func fetchWordMeaning(word: String, completion: @escaping (Result<Response, Error>) -> Void) {
        let url = baseUrl + word
        
        var urlRequest = URLRequest(url: URL(string: url)!)
        urlRequest.cachePolicy = .returnCacheDataElseLoad
        
        sessionManager.request(url, method: .get).responseData { response in
            switch response.result {
                case .success(let data):
                    do {
                        let decoder = JSONDecoder()
                        let response = try decoder.decode([Response].self, from: data)
                        
                        if let firstResponse = response.first{
                            completion(.success(firstResponse))
                        }
                    } catch {
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
}
