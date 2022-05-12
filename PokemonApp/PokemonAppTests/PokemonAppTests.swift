//
//  PokemonAppTests.swift
//  PokemonAppTests
//
//  Created by Admin on 10/05/2022.
//

import XCTest
@testable import PokemonApp

class PokemonAppTests: XCTestCase {
    var viewModel: ContentViewModel!
    var mockPokemonService: MockPokemonServices!
    
    override func setUp() {
        mockPokemonService = MockPokemonServices()
        viewModel = ContentViewModel(pokemonServices: mockPokemonService)
    }
    
    func testFetchPokemon() {
        
        mockPokemonService.result = .success(.mockPokemon)
        viewModel.searchPokemon()
        
        let exp = expectation(description: "Test after 5 seconds")
        let result = XCTWaiter.wait(for: [exp], timeout: 1.0)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertEqual(viewModel.pokemon.id, Pokemon.mockPokemon.id)
            XCTAssertFalse(viewModel.isEmptyState)
         } else {
             XCTFail("Delay interrupted")
         }
    }

    func testCatchPokemon() {
        mockPokemonService.result = .success(.mockPokemon)
        viewModel.searchPokemon()
        
        let exp = expectation(description: "Wait for Pokemon Search")
        let result = XCTWaiter.wait(for: [exp], timeout: 1.0)
        
        if result == XCTWaiter.Result.timedOut {
            XCTAssertFalse(viewModel.isEmptyState)
            XCTAssertEqual(viewModel.pokemon.id, Pokemon.mockPokemon.id)
            viewModel.catchPokemon()
            XCTAssertTrue(viewModel.isEmptyState)
         } else {
             XCTFail("Delay interrupted")
         }
    }
    
    func testCatchExistingPokemon() {
        mockPokemonService.result = .success(.mockPokemon)
        viewModel.searchPokemon()
        
        let exp = expectation(description: "Wait for Pokemon Search")
        let result = XCTWaiter.wait(for: [exp], timeout: 1.0)
        
        if result == XCTWaiter.Result.timedOut {
            XCTAssertFalse(viewModel.isEmptyState)
            XCTAssertEqual(viewModel.pokemon.id, Pokemon.mockPokemon.id)
            viewModel.catchPokemon()
            XCTAssertTrue(viewModel.isEmptyState)
            
            mockPokemonService.result = .success(.mockPokemon)
            viewModel.searchPokemon()
            
         } else {
             XCTFail("Delay interrupted")
         }
        
        let anotherExp = expectation(description: "Wait for Another Pokemon Search")
        let anotherResult = XCTWaiter.wait(for: [anotherExp], timeout: 2.0)
        
        if anotherResult == XCTWaiter.Result.timedOut {
            XCTAssertFalse(viewModel.isEmptyState)
            XCTAssertTrue(viewModel.isPokemonExist)
         } else {
             XCTFail("Delay interrupted")
         }
    }
    
    func testFetchPokemonFailed_NoPokemonFound() {
        mockPokemonService.result = .failure(NetworkingError.pageNotFound)
        viewModel.searchPokemon()
        
        let exp = expectation(description: "Test after 5 seconds")
        let result = XCTWaiter.wait(for: [exp], timeout: 5.0)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertEqual(viewModel.errorMessage, "No Pokemon Found")
            XCTAssertTrue(viewModel.isEmptyState)
         } else {
             XCTFail("Delay interrupted")
         }
    }
    
    func testFetchPokemonFailed_ErrorParsing() {
        mockPokemonService.result = .failure(NetworkingError.errorParsingJSON)
        viewModel.searchPokemon()
        
        let exp = expectation(description: "Test after 5 seconds")
        let result = XCTWaiter.wait(for: [exp], timeout: 5.0)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertEqual(viewModel.errorMessage, "Error Parsing Response")
            XCTAssertTrue(viewModel.isEmptyState)
         } else {
             XCTFail("Delay interrupted")
         }
    }
    
    func testFetchPokemonFailed_NoInternet() {
        mockPokemonService.result = .failure(NetworkingError.noInternet)
        viewModel.searchPokemon()
        
        let exp = expectation(description: "Test after 5 seconds")
        let result = XCTWaiter.wait(for: [exp], timeout: 5.0)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertEqual(viewModel.errorMessage, "Please Check Internet Connection")
            XCTAssertTrue(viewModel.isEmptyState)
         } else {
             XCTFail("Delay interrupted")
         }
    }
}




