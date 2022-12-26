//
//  Swift_OpenAiTests.swift
//  Swift-OpenAiTests
//
//  Created by Vince Carlo Santos on 12/24/22.
//

import XCTest
@testable import Swift_OpenAi

final class Swift_OpenAiTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

final class APIServiceTests: XCTestCase {
    let apiKey = ""
    func testGetAvailableModels() async {
        APIService.shared.setApiKey(key: apiKey)

        let result = await APIService.shared.getAvailableModels()

        switch result {
        case .success(let models):
            XCTAssert(models.count > 0, "Expected at least one model")
        case .failure(let error):
            XCTFail("Unexpected error: \(error.message)")
        }
    }

    func testGetModelCompletion() async {
        APIService.shared.setApiKey(key: apiKey)

        let result = await APIService.shared.getModelCompletion(model: "your_model", prompt: "your_prompt")

        switch result {
        case .success(let completion):
            XCTAssert(!completion.isEmpty, "Expected a non-empty completion")
        case .failure(let error):
            XCTFail("Unexpected error: \(error.message)")
        }
    }
}
