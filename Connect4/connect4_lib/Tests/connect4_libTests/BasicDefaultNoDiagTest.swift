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
    
    func testIsGameOver() throws {
        func expect(byPlayer playerId: Int,
                    withGrid grid: [[Int?]],
                    shouldBeOver: Bool,
                    shouldHaveWinner: Bool,
                    victoryTilesShouldBe: [(Int, Int)]?) {
            
            if let rules = BasicDefaultsNoDiag(withMinNbRows: 3, withMaxNbRows: 5, withMinNbCols: 3, withMaxNbCols: 5, withNbChipsToAlign: 3) {
                                
                XCTAssertEqual(shouldBeOver, rules.isGameOver(byPlayer: playerId, onGrid: grid).isOver)
                XCTAssertEqual(shouldHaveWinner, rules.isGameOver(byPlayer: playerId, onGrid: grid).hasWinner)
                XCTAssertFalse(rules.isGameOver(byPlayer: playerId, onGrid: grid).hasWinner && !(rules.isGameOver(byPlayer: playerId, onGrid: grid).isOver))
                
                if shouldHaveWinner {
                    XCTAssertTrue(rules.isGameOver(byPlayer: playerId, onGrid: grid).isOver)

                    let actualVictoryTiles = rules.isGameOver(byPlayer: playerId, onGrid: grid).victoryTiles
                    
                    XCTAssertNotNil(actualVictoryTiles)
    
                    for n in 0..<victoryTilesShouldBe!.count {
                        XCTAssertEqual(victoryTilesShouldBe![n].0, actualVictoryTiles![n].0)
                        XCTAssertEqual(victoryTilesShouldBe![n].1, actualVictoryTiles![n].1)
                    }
                }
            }
        }

        expect(byPlayer: 1,
               withGrid: [[nil, nil, nil],
                          [nil, nil, nil],
                          [nil, nil, nil]],
               shouldBeOver: false,
               shouldHaveWinner: false,
               victoryTilesShouldBe: nil)
        
        expect(byPlayer: 2,
               withGrid: [[nil, nil, nil],
                          [nil, nil, nil],
                          [2, nil, nil]],
               shouldBeOver: false,
               shouldHaveWinner: false,
               victoryTilesShouldBe: nil)
        
        expect(byPlayer: 1,
               withGrid: [[2, nil, nil],
                          [1, 1, 1],
                          [2, 2, 1]],
               shouldBeOver: true,
               shouldHaveWinner: true,
               victoryTilesShouldBe: [(1, 0), (1, 1), (1, 2)])
        
        expect(byPlayer: 2,
               withGrid: [[nil, nil, nil, nil, nil],
                          [nil, nil, nil, nil, nil],
                          [nil, nil, nil, nil, nil],
                          [nil, nil, nil, 1, nil],
                          [1, 1, 2, 2, 2]],
               shouldBeOver: true,
               shouldHaveWinner: true,
               victoryTilesShouldBe: [(4, 2), (4, 3), (4, 4)])
        
        expect(byPlayer: 1,
               withGrid: [[nil, nil, 1],
                          [nil, 2, 1],
                          [nil, 2, 1]],
               shouldBeOver: true,
               shouldHaveWinner: true,
               victoryTilesShouldBe: [(0, 2), (1, 2), (2, 2)])
        
        expect(byPlayer: 1,
               withGrid: [[1, 2, 1],
                          [1, 2, 1],
                          [2, 1, 2]],
               shouldBeOver: true,
               shouldHaveWinner: false,
               victoryTilesShouldBe: nil)
    }
}
