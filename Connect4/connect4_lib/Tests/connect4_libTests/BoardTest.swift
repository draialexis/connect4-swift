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
        
        expect(withGrid: [[nil, nil, nil], [nil, nil, nil], [nil, 1, 2]], shouldNotBeFull: true)
        expect(withGrid: [[1, 1, 2], [2, 2, 1], [2, 1, 2]], shouldNotBeFull: false)
        var board = Board(withGrid: [[1, nil, 2], [2, 2, 1], [2, 1, 2]])
        expect(withGrid: board!.grid, shouldNotBeFull: true)
        if(board!.insertChip(from: 1, atCol: 1)) {
            expect(withGrid: board!.grid, shouldNotBeFull: false)
        }
    }
    
    func testInsertChip() throws {
        func expect(withGrid orig: [[Int?]], playerId: Int, secretTargetRow: Int, targetCol: Int, shouldWork: Bool) {
            if shouldWork {
                XCTAssertNil(orig[secretTargetRow][targetCol])
                if var board = Board(withGrid: orig) {
                    XCTAssertTrue(board.insertChip(from: playerId, atCol: targetCol))
                    XCTAssertEqual(playerId, board.grid[secretTargetRow][targetCol])
                }
            } else {
                if var board = Board(withGrid: orig) {
                    XCTAssertFalse(board.insertChip(from: playerId, atCol: targetCol))
                    if  0 <= targetCol && targetCol < orig[0].count {
                        XCTAssertEqual(orig[secretTargetRow][targetCol], board.grid[secretTargetRow][targetCol])
                    }
                }
            }
        }
        
        // p1, ok
        expect(withGrid: [[nil, nil, nil], [nil, nil, nil], [nil, nil, nil]], playerId: 1, secretTargetRow: 2, targetCol: 0, shouldWork: true)
        // p2, ok
        expect(withGrid: [[nil, nil, nil], [nil, nil, nil], [nil, nil, nil]], playerId: 2, secretTargetRow: 2, targetCol: 0, shouldWork: true)
        // p3, nok
        expect(withGrid: [[nil, nil, nil], [nil, nil, nil], [nil, nil, nil]], playerId: 3, secretTargetRow: 2, targetCol: 0, shouldWork: false)
        // out of bounds left, nok
        expect(withGrid: [[nil, nil, nil], [nil, nil, nil], [nil, nil, nil]], playerId: 1, secretTargetRow: 2, targetCol: -1, shouldWork: false)
        // out of bounds right, nok
        expect(withGrid: [[nil, nil, nil], [nil, nil, nil], [nil, nil, nil]], playerId: 1, secretTargetRow: 2, targetCol: 3, shouldWork: false)
        // grid full, nok
        expect(withGrid: [[1, 2, 1], [1, 2, 1], [2, 1, 2]], playerId: 1, secretTargetRow: 0, targetCol: 1, shouldWork: false)
        // column full, nok
        expect(withGrid: [[nil, nil, 2], [nil, nil, 1], [nil, nil, 2]], playerId: 1, secretTargetRow: 0, targetCol: 2, shouldWork: false)

    }
}
