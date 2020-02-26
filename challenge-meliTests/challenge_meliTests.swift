//
//  challenge_meliTests.swift
//  challenge-meliTests
//
//  Created by Kevin Furman on 29/01/2020.
//  Copyright © 2020 Kevin Furman. All rights reserved.
//

import XCTest
import OHHTTPStubs
@testable import challenge_meli

class challenge_meliTests: XCTestCase {
    
    struct Constants {
        static let host = "api.mercadolibre.com"
        static let contentType = "application/json"
    }
    
    enum MockFileNames: String {
        case search = "searchMock.json"
        case description = "descriptionMock.json"
        case questions = "questionsMock.json"
        case itemDetail = "itemDetailMock.json"
    }

    override func tearDown() {
        HTTPStubs.removeAllStubs()
    }
    
    func testSearchService() {
        let exp = expectation(description: "Testing search service")
        
        stub(condition: isHost(Constants.host)) { _ in
            let stubPath = OHPathForFile(MockFileNames.search.rawValue, type(of: self))
            return fixture(filePath: stubPath!, headers: ["Content-Type": Constants.contentType])
        }
        
        var mockedResponse: SearchItemsResponse? = nil
        MeLiService.searchItems(query: "TEST", page: 0, completion: { (response, error) in
            mockedResponse = response
            exp.fulfill()
        })
        
        waitForExpectations(timeout: 3)
        
        XCTAssertNotNil(mockedResponse)
        XCTAssertEqual(mockedResponse?.results.count, 5, "Results count doesn't match.")
        XCTAssertEqual(mockedResponse?.results[0].id, "MLA835735664", "Item id doesn't match.")
        XCTAssertEqual(mockedResponse?.results[0].price, 26989.99, "Item price doesn't match.")
        XCTAssertEqual(mockedResponse?.results[0].thumbnail, URL(string: "http://mla-s1-p.mlstatic.com/702504-MLA31932877793_082019-I.jpg"), "Item thumbnail doesn't match.")
        XCTAssertEqual(mockedResponse?.results[0].title, "Motorola X4 32 Gb Negro 3 Gb Ram", "Item title doesn't match.")
    }
    
    func testItemDetailService() {
        let exp = expectation(description: "Testing item detail service")
        
        stub(condition: isHost(Constants.host)) { _ in
            let stubPath = OHPathForFile(MockFileNames.itemDetail.rawValue, type(of: self))
            return fixture(filePath: stubPath!, headers: ["Content-Type": Constants.contentType])
        }
        
        var mockedResponse: ItemDetailResponse? = nil
        MeLiService.fetchItem(id: "TEST", completion: { (response, error) in
            mockedResponse = response
            exp.fulfill()
        })
        
        waitForExpectations(timeout: 3)
        
        XCTAssertNotNil(mockedResponse)
        XCTAssertEqual(mockedResponse?.id, "MLA759498470", "Id doesn't match.")
        XCTAssertEqual(mockedResponse?.pictures.count, 5, "Pictures count doesn't match.")
        XCTAssertEqual(mockedResponse?.title, "Teg Juego De Mesa Original Ruibal", "Title doesn't match.")
        XCTAssertEqual(mockedResponse?.price, 2499.9, "Price doesn't match.")
    }

    func testDescriptionService() {
        let exp = expectation(description: "Testing description service")
        
        stub(condition: isHost(Constants.host)) { _ in
            let stubPath = OHPathForFile(MockFileNames.description.rawValue, type(of: self))
            return fixture(filePath: stubPath!, headers: ["Content-Type": Constants.contentType])
        }
        
        var mockedResponse: DescriptionResponse? = nil
        MeLiService.fetchDescription(id: "TEST", completion: { (response, error) in
            mockedResponse = response
            exp.fulfill()
        })
        
        waitForExpectations(timeout: 3)
        
        XCTAssertNotNil(mockedResponse)
        XCTAssertEqual(mockedResponse?.plainText, "Una pantalla más grande.", "Description plainText doesn't match.")
    }
    
    func testQuestionsService() {
        let exp = expectation(description: "Testing questions service")
        
        stub(condition: isHost(Constants.host)) { _ in
            let stubPath = OHPathForFile(MockFileNames.questions.rawValue, type(of: self))
            return fixture(filePath: stubPath!, headers: ["Content-Type": Constants.contentType])
        }
        
        var mockedResponse: QuestionsResponse? = nil
        MeLiService.fetchQuestions(id: "TEST", completion: { (response, error) in
            mockedResponse = response
            exp.fulfill()
        })
        
        waitForExpectations(timeout: 3)
        
        XCTAssertNotNil(mockedResponse)
        XCTAssertEqual(mockedResponse?.questions.count, 20, "Questions count doesn't match.")
        
        let firstQuestion = mockedResponse?.questions[0]
        XCTAssertEqual(firstQuestion?.text, "Hola tenes stock ? Es 100% original", "Question text doesn't match.")
        XCTAssertEqual(firstQuestion?.date.description, "2020-02-12 03:34:57 +0000", "Question date doesn't match.")
        XCTAssertEqual(firstQuestion?.answer?.text, "Hola!! Buen día. Si, tenemos stock. Podes efectuar tu compra. Si es el original", "Question answer text doesn't match.")
        XCTAssertEqual(firstQuestion?.answer?.date.description, "2020-02-12 10:36:26 +0000", "Question answer date doesn't match.")
    }

}
