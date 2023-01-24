import Foundation
import XCTest
import connect4_lib

final class BoardTest: XCTestCase {
    
    func testInit() throws {
        func expect(initBoardWithNbRows nbRows: Int,
                    andNbCols nbCols: Int,
                    shouldNotBeNil: Bool) {
            let board = Board(withRows: nbRows, andWithCols: nbCols)
            if !shouldNotBeNil {
                XCTAssertNil(board)
                return
            }
            XCTAssertNotNil(board)
            XCTAssertEqual(nbCols, board?.nbCols)
            XCTAssertEqual(nbRows, board?.nbRows)
        }
        
        expect(initBoardWithNbRows: 6, andNbCols: 7, shouldNotBeNil: true)
        expect(initBoardWithNbRows: -1, andNbCols: 7, shouldNotBeNil: false)
        expect(initBoardWithNbRows: 6, andNbCols: -9, shouldNotBeNil: false)
        expect(initBoardWithNbRows: 0, andNbCols: 7, shouldNotBeNil: false)
        expect(initBoardWithNbRows: 6, andNbCols: 0, shouldNotBeNil: false)
    }
    
    func testInitLoad() throws {
        func expect(withBoard orig: [[Int?]], shouldNotBeNil: Bool) {
            let board = Board(withGrid: orig)
            if !shouldNotBeNil {
                XCTAssertNil(board)
                return
            }
            XCTAssertNotNil(board)
            XCTAssertEqual(orig[0].count, board?.nbCols)
            XCTAssertEqual(orig.count, board?.nbRows)
        }
        
        expect(withBoard: [[0, 1, 2], [0, 0, 0], [0, 0, 0]], shouldNotBeNil: true)
        expect(withBoard: [], shouldNotBeNil: false)
        expect(withBoard: [[], []], shouldNotBeNil: false)
        expect(withBoard: [[0, 1], [0, 0]], shouldNotBeNil: false)
        expect(withBoard: [[0, 1, 2], [0, 0, 0, 0]], shouldNotBeNil: false)
    }
    
}
