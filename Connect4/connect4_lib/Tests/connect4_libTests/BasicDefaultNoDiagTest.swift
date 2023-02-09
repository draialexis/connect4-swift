import XCTest
import connect4_lib

final class BasicDefaultNoDiagTest: XCTestCase {
    func testInit() throws {
        func expect(withMinNbRows minNbRows: Int,
                    withMaxNbRows maxNbRows: Int,
                    withMinNbCols minNbCols: Int,
                    withMaxNbCols maxNbCols: Int,
                    withNbChipsToAlign nbChipsToAlign: Int,
                    shouldNotBeNil: Bool) {
            
            let rules = BasicDefaultsNoDiag(withMinNbRows: minNbRows,
                                            withMaxNbRows: maxNbRows,
                                            withMinNbCols: minNbCols,
                                            withMaxNbCols: maxNbCols,
                                            withNbChipsToAlign: nbChipsToAlign)
            
            if !shouldNotBeNil {
                XCTAssertNil(rules)
                return
            }
            XCTAssertNotNil(rules)
            XCTAssertEqual(minNbRows, rules?.minNbRows)
            XCTAssertEqual(maxNbRows, rules?.maxNbRows)
            XCTAssertEqual(minNbCols, rules?.minNbCols)
            XCTAssertEqual(maxNbCols, rules?.maxNbCols)
            XCTAssertEqual(nbChipsToAlign, rules?.nbChipsToAlign)
        }
        
        expect(withMinNbRows: 5, withMaxNbRows: 10, withMinNbCols: 5, withMaxNbCols: 10, withNbChipsToAlign: 3, shouldNotBeNil: true)
        expect(withMinNbRows: 1, withMaxNbRows: 10, withMinNbCols: 5, withMaxNbCols: 10, withNbChipsToAlign: 3, shouldNotBeNil: false)
        expect(withMinNbRows: 5, withMaxNbRows: 10, withMinNbCols: 1, withMaxNbCols: 10, withNbChipsToAlign: 3, shouldNotBeNil: false)
        expect(withMinNbRows: 5, withMaxNbRows: 4, withMinNbCols: 5, withMaxNbCols: 10, withNbChipsToAlign: 3, shouldNotBeNil: false)
        expect(withMinNbRows: 5, withMaxNbRows: 10, withMinNbCols: 5, withMaxNbCols: 4, withNbChipsToAlign: 3, shouldNotBeNil: false)
        expect(withMinNbRows: 5, withMaxNbRows: 10, withMinNbCols: 5, withMaxNbCols: 10, withNbChipsToAlign: 1, shouldNotBeNil: false)
        expect(withMinNbRows: 5, withMaxNbRows: 10, withMinNbCols: 5, withMaxNbCols: 12, withNbChipsToAlign: 11, shouldNotBeNil: false)
        expect(withMinNbRows: 5, withMaxNbRows: 12, withMinNbCols: 5, withMaxNbCols: 10, withNbChipsToAlign: 11, shouldNotBeNil: false)
    }
    
    func testIsValid() throws {
        func expect(board: Board,
                    shouldBeValid: Bool) {
            print(board)
            guard let rules = BasicDefaultsNoDiag(withMinNbRows: 5,
                                                  withMaxNbRows: 8,
                                                  withMinNbCols: 5,
                                                  withMaxNbCols: 9,
                                                  withNbChipsToAlign: 4) else { XCTAssertFalse(true); return }
            
            XCTAssertEqual(shouldBeValid, rules.isValid(board))
        }
        
        expect(board: Board(withRows: 5, andWithCols: 9)!, shouldBeValid: true)
        expect(board: Board(withRows: 4, andWithCols: 9)!, shouldBeValid: false)
        expect(board: Board(withRows: 9, andWithCols: 9)!, shouldBeValid: false)
        expect(board: Board(withRows: 5, andWithCols: 4)!, shouldBeValid: false)
        expect(board: Board(withRows: 5, andWithCols: 10)!, shouldBeValid: false)
    }
    
    func testIsGameOver() throws {
        func expect(byPlayer playerId: Int,
                    withGrid grid: [[Int?]],
                    resultShouldBe: Result) {
             
            if let rules = BasicDefaultsNoDiag(withMinNbRows: 3, withMaxNbRows: 5, withMinNbCols: 3, withMaxNbCols: 5, withNbChipsToAlign: 3) {
                
                let gameStatus = rules.isGameOver(byPlayer: playerId, onGrid: grid)
                
                XCTAssertEqual(resultShouldBe, gameStatus.result)
            }
        }
        
        expect(byPlayer: 1,
               withGrid: [[nil, nil, nil],
                          [nil, nil, nil],
                          [nil, nil, nil]],
               resultShouldBe: .notOver)
        
        expect(byPlayer: 2,
               withGrid: [[nil, nil, nil],
                          [nil, nil, nil],
                          [2, nil, nil]],
               resultShouldBe: .notOver)
        
        expect(byPlayer: 1,
               withGrid: [[2, nil, nil],
                          [1, 1, 1],
                          [2, 2, 1]],
               resultShouldBe: .won(1, [(1, 0), (1, 1), (1, 2)]))
        
        expect(byPlayer: 2,
               withGrid: [[nil, nil, nil, nil, nil],
                          [nil, nil, nil, nil, nil],
                          [nil, nil, nil, nil, nil],
                          [nil, nil, nil, 1, nil],
                          [1, 1, 2, 2, 2]],
               resultShouldBe: .won(2, [(4, 2), (4, 3), (4, 4)]))
        
        expect(byPlayer: 1,
               withGrid: [[nil, nil, 1],
                          [nil, 2, 1],
                          [nil, 2, 1]],
               resultShouldBe: .won(1, [(0, 2), (1, 2), (2, 2)]))

        expect(byPlayer: 1,
               withGrid: [[1, 2, 1],
                          [1, 2, 1],
                          [2, 1, 2]],
               resultShouldBe: .deadlocked)
    }
}
