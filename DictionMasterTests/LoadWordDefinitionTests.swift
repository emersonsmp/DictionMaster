//
//  LoadWordDefinitionTests.swift
//  DictionMasterTests
//
//  Created by Emerson Sampaio on 09/02/24.
//

import XCTest
@testable import DictionMaster

final class LoadWordDefinitionTests: XCTestCase {
    var viewModel: WordResultViewModel!
    
    @MainActor override func setUp() {
        super.setUp()
        viewModel = WordResultViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    @MainActor func testFetchItemsSuccess() {
        let expectation = XCTestExpectation(description: "Fetch items success")
        
        let word = "home"
        viewModel.fetchItems(word: word)
        
        let asyncWaitDuration = 3.0
        DispatchQueue.main.asyncAfter(deadline: .now() + asyncWaitDuration) {
            XCTAssertEqual(self.viewModel.response?.word, word)
            XCTAssertFalse(self.viewModel.definitions.isEmpty)
            XCTAssertEqual(self.viewModel.state, .success)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: asyncWaitDuration)
    }
}
