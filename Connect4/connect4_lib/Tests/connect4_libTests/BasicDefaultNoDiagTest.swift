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
        func expect() {
            
        }
    }
}
