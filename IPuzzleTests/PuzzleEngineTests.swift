//
//  PuzzleEngineTests.swift
//  IPuzzleTests
//
//  Created by Hawkar Jamal Ali on 2020-12-09.
//

import XCTest
@testable import IPuzzle

class PuzzleEngineTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSwappingPuzzlePieces() throws {
        let puzzleEngine = PuzzleEngine()
        var puzzlePieces = puzzleEngine.createPuzzle(image: #imageLiteral(resourceName: "testImage.jpg"), into: 3)
        var puzzlePieces2 = puzzlePieces
        
        let puzzlePiecesToSwap = [puzzlePieces2.removeFirst(),puzzlePieces2.removeLast()]
        
        let result = puzzleEngine.swapPuzzlePieces(puzzlePieces: puzzlePiecesToSwap, puzzleArray: &puzzlePieces)
        
        XCTAssertEqual(result.count, 2)
        XCTAssertNotEqual(puzzlePiecesToSwap[0], puzzlePieces[0])
        XCTAssertNotEqual(puzzlePiecesToSwap[1], puzzlePieces[8])
        
    }
    
    func testCreatingPuzzle() throws {
        let puzzleEngine = PuzzleEngine()
        let puzzlePieces = puzzleEngine.createPuzzle(image: #imageLiteral(resourceName: "testImage.jpg"), into: 3)
        
        XCTAssertEqual(puzzlePieces.count, 9)
    }

}
