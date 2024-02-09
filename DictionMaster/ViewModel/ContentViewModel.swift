//
//  ContentViewModel.swift
//  DictionMaster
//
//  Created by Emerson Sampaio on 07/02/24.
//

import Foundation
import Alamofire

class ContentViewModel: ObservableObject {
    
    @Published var isNavigationActive = false
    @Published var word: String = ""
    
    private var searchCount: Int {
        UserDefaults.standard.integer(forKey: Constants.searchCountKey)
    }
    
    private var lastSearchDate: Date? {
        UserDefaults.standard.object(forKey: Constants.lastSearchDateKey) as? Date
    }
    
    func goToSearch(){
        if(isValid()){
            isNavigationActive = true
        }else{
            
        }
    }
    
    func canPerformSearch() -> Bool {
        guard let lastSearchDate = lastSearchDate else { return true }
        
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let lastSearchDay = calendar.startOfDay(for: lastSearchDate)
        
        if today != lastSearchDay {
            resetSearchCounter()
            return true
        }
        
        return searchCount < Constants.maxSearchesPerDay
    }
    
    private func isValid() -> Bool {
        let forbiddenCharacters = CharacterSet(charactersIn: "!@#$%^&*()_+={}[]|\\:;\"'<>,.?/~")
        
        if word.isEmpty || word.contains(" ") || word.rangeOfCharacter(from: .decimalDigits) != nil
            || word.rangeOfCharacter(from: forbiddenCharacters) != nil {
            return false
        }
        
        return true
    }
    
    func incrementSearchCount() {
        UserDefaults.standard.set(searchCount + 1, forKey: Constants.searchCountKey)
        UserDefaults.standard.set(Date(), forKey: Constants.lastSearchDateKey)
    }
    
    func resetSearchCounter() {
        UserDefaults.standard.set(0, forKey: Constants.searchCountKey)
        UserDefaults.standard.set(Date(), forKey: Constants.lastSearchDateKey)
    }
}

