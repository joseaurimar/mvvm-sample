//
//  APIManagerTests.swift
//  sword-health-test
//
//  Created by MAC on 15/02/2025.
//

import XCTest

final class APIManagerTests: XCTestCase {
    
    var mockAPIManager: MockAPIManager?
    
    override func setUp() {
        mockAPIManager = MockAPIManager()
    }
    
    func testfetchCatBreedsWithSuccess() {
        let expectedData = [CatBreedResponse]()
        mockAPIManager?.mockData = expectedData
        
        mockAPIManager?.fetchCatBreeds(pageSize: 0) { result in
            switch result {
            case .success(let data):
                XCTAssertEqual(data, expectedData)
            case .failure:
                XCTFail("This test shouldnt fail!")
            }
        }
    }
    
    func testfetchCatBreedsWithFail() {
        mockAPIManager?.shouldReturnError = true
        
        mockAPIManager?.fetchCatBreeds(pageSize: 0) { result in
            switch result {
            case .success:
                XCTFail("This test should fail!")
            case .failure(let error):
                XCTAssertEqual(error, HttpError.badRequest)
            }
        }
    }
    
    func testSearchCatBreedWithSuccess() {
        let expectedData = [CatBreedResponse]()
        mockAPIManager?.mockData = expectedData
        
        mockAPIManager?.searchCatBreed(by: "", pageSize: 0) { result in
            switch result {
            case .success(let data):
                XCTAssertEqual(data, expectedData)
            case .failure:
                XCTFail("This test shouldnt fail!")
            }
        }
    }
    
    func testSearchCatBreedWithFail() {
        mockAPIManager?.shouldReturnError = true
        
        mockAPIManager?.searchCatBreed(by: "", pageSize: 0) { result in
            switch result {
            case .success:
                XCTFail("This test should fail!")
            case .failure(let error):
                XCTAssertEqual(error, HttpError.serverError)
            }
        }
    }
}
