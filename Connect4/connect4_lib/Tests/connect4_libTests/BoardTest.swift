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
        expect(initBoardWithNbRows: 6, andNbCols: 2, shouldNotBeNil: false)
        expect(initBoardWithNbRows: 2, andNbCols: 4, shouldNotBeNil: false)
    }
    
    func testInitLoad() throws {
        func expect(withGrid orig: [[Int?]], shouldNotBeNil: Bool) {
            let board = Board(withGrid: orig)
            if !shouldNotBeNil {
                XCTAssertNil(board)
                return
            }
            XCTAssertNotNil(board)
            XCTAssertEqual(orig[0].count, board?.nbCols)
            XCTAssertEqual(orig.count, board?.nbRows)
        }
        
        expect(withGrid: [[nil, nil, nil], [nil, nil, nil], [nil, 1, 2]], shouldNotBeNil: true)
        expect(withGrid: [], shouldNotBeNil: false)
        expect(withGrid: [[], []], shouldNotBeNil: false)
        expect(withGrid: [[nil, nil], [nil, 1]], shouldNotBeNil: false)
        expect(withGrid: [[nil, nil, nil], [nil, nil, 1, 2]], shouldNotBeNil: false)
        expect(withGrid: [[nil, nil, nil], [nil, nil, nil], [nil, 1, 3]], shouldNotBeNil: false)
    }
    
    func testIsFull() throws {
        func expect(withGrid orig: [[Int?]], shouldNotBeFull: Bool) {
            let board = Board(withGrid: orig)
            if shouldNotBeFull {
                XCTAssertFalse(board!.isFull())
            } else {
                XCTAssertTrue(board!.isFull())
            }
        }
        
        expect(withGrid: [[nil, 1, 2], [nil, nil, nil], [nil, nil, nil]], shouldNotBeFull: true)
        expect(withGrid: [[1, 1, 2], [2, 2, 1], [2, 1, 2]], shouldNotBeFull: false)
        var board = Board(withGrid: [[1, nil, 2], [2, 2, 1], [2, 1, 2]])
        expect(withGrid: board!.grid, shouldNotBeFull: true)
        if(board!.insertChip(from: 1, atCol: 1)) {
            expect(withGrid: board!.grid, shouldNotBeFull: false)
        }
    }
}
