//
//  ImageLinkTests.swift
//  IPuzzleTests
//
//  Created by hawkar on 2020-12-08.
//

import XCTest
@testable import IPuzzle

class ImageLinkTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testImageLinkType() throws {
        let image = UIImageView()
        let urlTest1 = "www.google.se"
        let urlTest2 = "https://picsum.photos/id/10/2500/1667"
        
        XCTAssertFalse(image.downloadImage(from: urlTest1))
        XCTAssertTrue(image.downloadImage(from: urlTest2))
    }
    
    func testDownloadingImages () throws {
        var imageUrls = [String]()
        let downloadImages = DownloadImages()
        let imageExpectation = expectation(description: "images")
        
        downloadImages.getImages(page: 2, amount: 6) { (imageLinks) in
            imageUrls = imageLinks
            imageExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1) { (error) in
            XCTAssertEqual(imageUrls.count, 6)
        }
      
    }
}
